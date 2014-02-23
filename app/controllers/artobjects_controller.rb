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

    if params[:tags] && !params[:tags].empty?
      @artobjects = @artobjects.tagged_with(params[:tags]).paginate(page: params[:page])
    end

    if params[:ascending]
      if params[:ascending] == "false"
        @artobjects = @artobjects.reorder('minyear DESC').paginate(page: params[:page])
      elsif params[:ascending] == "true"
        @artobjects = @artobjects.reorder('minyear ASC').paginate(page: params[:page])
      end
    end


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
      end
      if params[:max_bce]
        @artobject.maxyear = @artobject.maxyear*-1
      end
      if params[:image].nil?
        @artobject.image = File.open("#{Rails.root}/app/assets/images/default.png")
      end
      @artobject.save
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
      params.require(:artobject).permit(:name, :minyear, :maxyear, :image, :creator_list, :language_list, :location_list, :society_list, :medium_list)
    end

    def admin_user
      @artobject = Artobject.find_by(id: params[:id])
      redirect_to(artobjects_url) unless current_user.admin?
    end

end
