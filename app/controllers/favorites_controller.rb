class FavoritesController < ApplicationController
  def create
  	User.find(current_user.id).favorite_objects << Artobject.find(params[:artobject])

  	respond_to do |format|
      format.json { head :ok}
    end
  end

  def destroy
  	favorite = Favorite.find_by_user_id_and_artobject_id(current_user.id, params[:id]).destroy

  	respond_to do |format|
      format.json { head :ok}
    end
  end
end
