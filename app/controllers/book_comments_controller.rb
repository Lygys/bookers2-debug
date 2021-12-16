class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @ncomment = current_user.book_comments.new(book_comment_params)
    @ncomment.book_id = @book.id
    @ncomment.save
    redirect_to request.referer
  end

  def destroy
    BookComment.find_by(id: params[:book_comment_id]).destroy
    redirect_to request.referer
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
