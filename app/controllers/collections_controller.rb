class CollectionsController < ApplicationController
  include FileUploadModule

  respond_to :json

  # ==== DOCUMENTATION ====
  # api :GET, "/collections", "Returns all the collections."
  # description "Returns all the tests to which current user has access."
  # param_group :auth, ApplicationController
  # error code: 403, desc: "Requesting user is a student"
  # formats ['json']
  # ==== ACTION ====
  def index
    respond_with Collection.all
  end

  # ==== DOCUMENTATION ====
  # api :GET, "/mc_tests", "Returns a test."
  # description "Returns a specific test."
  # param_group :auth, ApplicationController
  # param :id, String, desc: "ID of the event", required: true
  # error code: 403, desc: "Requesting user is a student"
  # error code: 403, desc: "The requested event is not a Hstry event or one of the requesting user's events"
  # error code: 412, desc: "`id` parameter is missing"
  # error code: 422, desc: "`id` parameter is not a valid test id"
  # formats ['json']
  # ==== AUTHORIZATION ====
  # filter_access_to  :show,
  #  attribute_check: true
  # ==== ACTION ====
  def show
    render json: Collection.find(params.require(:id))
  end

  # ==== DOCUMENTATION ====
  # api :POST, "/mc_tests", "Create a new test for a client"
  # description "Creates a new test. The test is not published."
  # Client id is recorded
  # param_group :auth, ApplicationController
  # param :mc_test, Hash, desc: "McTest" do
  #  param :title, String, required: true
  # end
  # error code: 403, desc: "Current user is not a teacher"
  # error code: 412, desc: "Event data is non existent"
  # formats ['json']
  # example '{
  # }'
  # ==== ACTION ====
  def create
    collection = Collection.create(
      title: params[:title],
      author: current_user,
      introduction_content: ""
    )
    item = Item.create(
      collection: collection,
      content: ""
    )

    respond_with collection, location: ''
  end

  # ==== DOCUMENTATION ====
  # api :PUT, "/mc_tests/:id", "Updates an test."
  # description "Saves a test."
  # param_group :auth, ApplicationController
  # param :id, String, desc: "Id of the test", required: true
  # param :mc_test, Hash, desc: "McTest", required: true do
  #  param :title, String, required: true
  #  param :is_dirty, String, desc: "Indicates whether the test is dirty or not.", required: true
  # end
  # error code: 403, desc: "Current user is not a teacher"
  # error code: 403, desc: "Current user is the author of the event"
  # error code: 412, desc: "Event data is non existent"
  # formats ['json']
  # example '{
  # }'
  # ==== AUTHORIZATION ====
  # filter_access_to  :update,
  #  attribute_check: true
  # ==== ACTION ====
  def update
    collection = Collection.find(params[:id])

    collection.title = update_params[:title]
    collection.introduction_content = update_params[:introduction_content]
    # timeline.is_published = update_params[:is_published]
    # Set the first publication date if it's not set already, i.e. if it's the first time this timeline is published
    # timeline.first_published_at = DateTime.now if timeline.first_published_at.nil?
    # Cover
    update_attachment(update_params[:cover], collection, :cover, :cover_caption, Collection.uploader_for(:cover))

    collection.save!

    if @attachment_uploaded
      respond_with collection, root: :timeline, responder: Responders::PutWithContentResponder
    else
      respond_with collection
    end
  end


  # ==== DOCUMENTATION ====
  # api :DELETE, "/mc_tests/:id", "Deletes a test"
  # description "Deletes a test"
  # param_group :auth, ApplicationController
  # param :id, String, desc: "ID of the timeline"
  # error code: 422, desc: "Wrong ID for the timeline"
  # formats ['json']
  # ==== ACTION ====
  def destroy
    collection = Collection.find(params.require(:id))

    collection.destroy

    respond_with collection, location: ''
  end

  private
  
  def update_params
    params.require(:collection).permit(
      :title, :cover, :introduction_content, :author
    )
  end

  def create_params
    params.require(:collection).permit(:title, :author)
  end

end