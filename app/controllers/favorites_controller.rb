class FavoritesController < ApplicationController

  before_action :set_book
  def set_book
    @book = Book.find(params[:book_id])
  end

  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    redirect_to book_path(@book)
  end

  def destroy
    faborite = current_user.favorites.find_by(book_id: @book.id)
    faborite.destroy
    redirect_to book_path(@book)
  end
end
