# app/controllers/bookmarks_controller.rb
class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Movie was successfully added to the list.'
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully deleted.'
  end

  private

  # def bookmark_params
  #   params.require(:bookmark).permit(:movie_id, :comment)
  # end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end