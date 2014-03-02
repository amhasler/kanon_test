class ArtobjectsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :admin_user, only: :destroy
  before_action :object_editor, only: :update

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
    if params[:tags] && !params[:tags].empty?
      @tags = params[:tags].split(', ');
      @tags.each do |t|
        logger.debug(t)
        if Artobject.search(t).count > 0
          @tags.delete_at(@tags.find_index(t))
          @artobjects = Artobject.search(t).paginate(page: params[:page])
          @query = t
        end   
      end
      if !@tags.empty?
        @artobjects = @artobjects.tagged_with(@tags).paginate(page: params[:page])
      end
      if @query 
        @tags << @query
        @tags = @tags.join(', ')
      end
    end

    render 'index'
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

    def object_editor
      @artobject = Artobject.find_by(id: params[:id])
      redirect_to(artobjects_url) unless current_user.id == @artobject.user_id || current_user.admin?
    end

end
