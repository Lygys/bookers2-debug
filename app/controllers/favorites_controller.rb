class FavoritesController < ApplicationController

  before_action :set_book

  def set_book
    @book = Book.find(params[:book_id])
  end


  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    redirect_to request.referer
  end
end
