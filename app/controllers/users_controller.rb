class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy ]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @artobjects = @user.artobjects.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to Project Page One!"
      redirect_to artobjects_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    logger.debug('fire1')
    @user = User.find(params[:id])
    if @user.artobjects.count > 0
      logger.debug('fire2')
      @user.artobjects.each do |a|
        a.update_attributes(user_id:nil)
      end
    end
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def artobjects
    @user = User.find(params[:id])
    @artobjects = @user.favorite_objects
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
