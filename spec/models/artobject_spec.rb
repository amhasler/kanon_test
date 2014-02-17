require 'spec_helper'

describe Artobject do

  let(:user) { FactoryGirl.create(:user) }
  before { @artobject = user.artobjects.build(name: "The Republic", minyear: 1170, image: File.new('spec/fixtures/images/test_image.jpg'))}

  subject { @artobject }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:minyear) }
  it { should respond_to(:image) }
  its(:user) { should eq user }

  it { should be_valid }
  
  describe "with blank name" do
    before { @artobject.name = " " }
    it { should_not be_valid }
  end

  describe "with blank date" do
    before { @artobject.minyear = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @artobject.name = "a" * 41 }
    it { should_not be_valid }
  end

  describe "with photo that's too big" do
    before { @artobject.image = File.new(Rails.root + 'spec/fixtures/images/war.png')}
    it { should_not be_valid }
  end
end