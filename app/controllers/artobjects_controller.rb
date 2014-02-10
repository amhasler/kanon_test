class ArtobjectsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :admin_user, only: :destroy

  def create
  	@artobject = current_user.artobjects.build(artobject_params)
    if @artobject.save
      flash[:success] = "Art object created!"
      redirect_to artobjects_url
    else
      render 'index'
    end
  end

  def index
  	@artobjects = Artobject.paginate(page: params[:page])
  	@artobject = current_user.artobjects.build if signed_in?
  end

  def destroy
    @artobject.destroy
    redirect_to artobjects_url
  end

  private

    def artobject_params
      params.require(:artobject).permit(:name)
    end

    def admin_user
      @artobject = Artobject.find_by(id: params[:id])
      redirect_to(artobjects_url) unless current_user.admin?
    end

end
