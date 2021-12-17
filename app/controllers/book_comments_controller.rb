class BookCommentsController < ApplicationController
  before_action :set_book
  def  set_book
    @book = Book.find(params[:book_id])
  end


  def create

    @ncomment = current_user.book_comments.new(book_comment_params)
    @ncomment.book_id = @book.id
    if @ncomment.save
      redirect_to book_path(@book)
    else
      @nbook = Book.new
      @book = Book.find(params[:book_id])
      @comments = BookComment.where(book_id: @book.id)
      render 'books/show'
    end
  end

  def destroy
    BookComment.find_by(params[:book_comment_id]).destroy
    redirect_to request.referer
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
