class ItemsController < ApplicationController
  include FileUploadModule

  respond_to :json

  # ==== DOCUMENTATION ====
  # api :GET, "/cards", "Returns all the cards for an test."
  # description "Returns all the cards for an test."
  # param_group :auth, ApplicationController
  # param :mc_test_id, String, desc: "ID of the test", required: true
  # formats ['json']
  # error code: 401, desc: "User is not logged in"
  # ==== ACTION ====
  def index
    respond_with Collection.find(params.require(:collection_id)).items
  end

  # ==== DOCUMENTATION ====
  # api :POST, "/cards", "Create a new card"
  # description "Creates a new card"
  # param_group :auth, ApplicationController
  # param :card, Hash, desc: "Card" do
  #  param :timeline, String, desc: "ID of its test", required: true
  #  param :content, String, desc: "Card content", required: true
  #  param :type, String, desc: "Card type", required: true
  #  param :position, String, desc: "Card position", required: true
    # Image item
  #  param :image, Hash, desc: "Image attachment" do
  #    param :url, String, desc: "URL of the image", required: true
  #    param :caption, String, desc: "Caption of the image", required: true
  #  end
  # end
  # error code: 403, desc: "User is not the owner of the timeline"
  # formats ['json']
  # ==== AUTHORIZATION ====
  # filter_access_to  :create,
  #  attribute_check: true,
  #  load_method: :load_timeline_from_item
  # ==== ACTION ====
  def create
    item = Item.new()

    item.collection = Collection.find(create_params[:collection])
    set_item_attributes(item, create_params)

    respond_with item, location: '', root: :item
  end

  # ==== DOCUMENTATION ====
  # api :PUT, "/cards/:id", "Updates a card"
  # description "Updates the content, the position or the image of an card"
  # param_group :auth, ApplicationController
  # param :id, String, desc: "ID of the card"
  # param :card, Hash, desc: "Card" do
  #  param :content, String, desc: "Card content", required: true
  #  param :type, String, desc: "Card type", required: true
  #  param :position, String, desc: "Card position", required: true
    # Video item
    # param :youtube_video_id, String, desc: "Youtube video ID"
    # Image item
  #  param :image, Hash, desc: "Image attachment" do
  #    param :identifier, String, desc: "Identifier of the image", required: true
  #    param :url, String, desc: "URL of the image", required: true
  #    param :caption, String, desc: "Caption of the image", required: true
  #  end
  # end
  # error code: 403, desc: "User is not the owner of the timeline"
  # error code: 422, desc: "Wrong ID for the Item"
  # formats ['json']
  # ==== AUTHORIZATION ====
  # filter_access_to  :update,
  #  attribute_check: true
  # ==== ACTION ====
  def update
    item = Item.find(params.require(:id))

    # Update the item
    set_item_attributes(item, update_params)

    if @attachment_uploaded
      respond_with item, location: '', root: :item, responder: Responders::PutWithContentResponder
    else
      respond_with item, location: '' 
    end
  end

  # ==== DOCUMENTATION ====
  # api :DELETE, "/cards/:id", "Deletes an card"
  # description "Deletes an card"
  # param_group :auth, ApplicationController
  # param :id, String, desc: "ID of the card"
  # error code: 403, desc: "User is not the owner of the test"
  # error code: 422, desc: "Wrong ID for the Card"
  # formats ['json']
  # ==== AUTHORIZATION ====
  # filter_access_to  :destroy,
  #  attribute_check: true
  # ==== ACTION ====
  def destroy
    item = Item.find(params.require(:id))

    item.destroy

    respond_with item, location: ''
  end

  private
  def set_item_attributes(item, params)
    item.content = params[:content]
    item.position = params[:position]

    item.save!
  end

  def create_params
    params.require(:item).permit(:collection, :introduction_content, :position,
                                  :content, :artobject)
  end

  def update_params
    params.require(:item).permit(:collection, :introduction_content, :position,
                                  :content, :artobject)
  end

  def load_collection_from_item
    Collection.find(create_params[:collection])
  end

end