class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.includes(bookmarks: :movie).all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks
  end

  def new
    @list = List.new
    @list.bookmarks.build
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list), notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(@list), notice: 'List was successfully updated.'
    else
      render :edit
    end
  end
  

  def destroy
    @list = List.find(params[:id])
    @list.bookmarks.destroy_all
    @list.destroy
    redirect_to lists_path, notice: 'List and associated bookmarks were successfully deleted.'
  end

  private

  def set_list
    @list = List.find(params[:id])
  end


  def list_params
    params.require(:list).permit(:name, bookmarks_attributes: [:id, :movie_id, :comment, :_destroy])
  end
end