class ArtobjectsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :admin_user, only: [:destroy, :update]

  def create
  	@artobject = current_user.artobjects.build(artobject_params)
    if params[:min_bce]
      @artobject.minyear = @artobject.minyear*-1
    end
    if params[:max_bce]
      @artobject.maxyear = @artobject.maxyear*-1
    end
    if @artobject.save
      flash[:success] = "Art object created!"
      redirect_to artobjects_url
    else
      @artobjects = Artobject.paginate(page: params[:page])
      render 'index'
    end
  end

  def index
  	@artobjects = Artobject.paginate(page: params[:page])
    if params[:id]
      @artobject = Artobject.find(params[:id])
    else
  	  @artobject = current_user.artobjects.build if signed_in?
    end
  end

  def update
    @artobject = Artobject.find(params[:id])
    if @artobject.update_attributes(artobject_params)
      if params[:min_bce]
        @artobject.minyear = @artobject.minyear*-1
        @artobject.save
      end
      if params[:max_bce]
        @artobject.maxyear = @artobject.maxyear*-1
        @artobject.save
      end
      flash[:success] = "Art object updated"
      redirect_to artobjects_url
    else
      @artobjects = Artobject.paginate(page: params[:page])
      render 'index'
    end
  end

  def destroy
    @artobject.destroy
    redirect_to artobjects_url
  end

  private

    def artobject_params
      params.require(:artobject).permit(:name, :minyear, :maxyear)
    end

    def admin_user
      @artobject = Artobject.find_by(id: params[:id])
      redirect_to(artobjects_url) unless current_user.admin?
    end

end
