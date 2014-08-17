class ArtobjectsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :destroy]
  before_action :object_editor, only: [:edit, :update, :destroy]

  def index
    json_artobjects = Artobject.all
    @artobjects = Artobject.paginate(page: params[:page])
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
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: json_artobjects }
    end
  end

  def show
    @artobject = Artobject.find(params[:id])
    respond_to do |format|
      format.html { 
        @artobject
        add_breadcrumb @artobject.name, artobject_path(@artobject)
      }
      format.json { render json: @artobject }
    end
  end

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
      render 'new'
    end
  end

  def new
    @artobject = Artobject.new
    add_breadcrumb "New", :new_artobject_path
  end

  def edit
    @artobject = Artobject.find(params[:id])
    add_breadcrumb @artobject.name, artobject_path(@artobject)
    add_breadcrumb "Edit", edit_artobject_path(@artobject)
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
      respond_to do |format|
        format.html { 
          flash[:success] = "Art object updated"
          redirect_to artobjects_url
        }
        format.json { render json: @artobject }
      end
    else
      @artobjects = Artobject.paginate(page: params[:page])
      render 'index'
    end
  end

  

  def destroy
    @artobject = Artobject.find(params[:id])
    @artobject.destroy

    respond_to do |format|
      format.html { 
        flash[:success] = "Work deleted."
        redirect_to artobjects_url
      }
      format.json { render json: @artobject, location: '' }
    end
  end

  def users
    @artobject = Artobject.find(params[:id])
    @users = @artobject.favorited
    add_breadcrumb @artobject.name, artobject_path(@artobject)
    add_breadcrumb "Fans", users_artobject_path(@artobject)
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
