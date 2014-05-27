require 'file_size_validator' 

class User < ActiveRecord::Base
  include MaxTagSize

  mount_uploader :image, ImageUploader

  has_many :artobjects
  has_many :favorites, dependent: :destroy
  has_many :favorite_objects, through: :favorites, source: :artobject 
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  									format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :password, :length => { minimum: 6 }, :on => :create
  validate :max_tag_size
  validates :image, 
    :file_size => { 
    :maximum => 4.megabytes.to_i 
  }

  self.per_page = 14

  acts_as_taggable_on :creators, :locations, :languages, :societies, :mediums

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(query)
    where("lower(name) LIKE ?", "%#{query.downcase}%") 
  end

  def password_required?
    
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    
end
