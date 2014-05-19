class TagsController < ApplicationController
  def index
    query = params[:q]

    tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{query}%")
    if tags.empty?
      respond_to do |format|
        format.json { render json: [{id: "#{query}", name: "New: \"#{query}\""}] }
      end
    else
      respond_to do |format|
        format.json { render :json => tags.map{|t| {:id => t.name, :name => t.name }}}
      end
    end
  end
end
