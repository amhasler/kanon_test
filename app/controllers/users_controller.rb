class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy ]
  before_action :correct_user,   only: [:edit, :update, :destroy ]
  
  def index
    @users = User.paginate(page: params[:page])
    if params[:tags] && !params[:tags].empty?
      @tags = params[:tags].split(', ');
      @tags.each do |t|
        logger.debug(t)
        if User.search(t).count > 0
          @tags.delete_at(@tags.find_index(t))
          @users = User.search(t).paginate(page: params[:page])
          @query = t
        end   
      end
      if !@tags.empty?
        @users = @users.tagged_with(@tags).paginate(page: params[:page])
      end
      if @query 
        @tags << @query
        @tags = @tags.join(', ')
      end
    end
  end

  def show
    @user = User.find(params[:id])
    add_breadcrumb @user.name, user_path(@user)
  end

  def new
    @user = User.new
    add_breadcrumb "New", :new_user_path
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
    @user = User.find(params[:id])
    add_breadcrumb @user.name, user_path(@user)
    add_breadcrumb "Edit", edit_user_path(@user)
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
    @user = User.find(params[:id])
    if @user.artobjects.count > 0
      @user.artobjects.each do |a|
        a.update_attributes(user_id:nil)
        a.save
      end
    end
    @user.destroy
    flash[:success] = "Contributor deleted."
    redirect_to users_url
  end

  def artobjects
    @user = User.find(params[:id])
    @artobjects = @user.favorite_objects
    add_breadcrumb @user.name, user_path(@user)
    add_breadcrumb "Favorite Works", artobjects_user_path(@user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image, 
                                   :creator_list, :language_list, 
                                   :location_list, :society_list, :medium_list)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

end
