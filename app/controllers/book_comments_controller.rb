class BookCommentsController < ApplicationController


  def create
    @book = Book.find(params[:book_id])
    @ncomment = current_user.book_comments.new(book_comment_params)
    @ncomment.book_id = @book.id
    if @ncomment.save
      render 'book_comments/crate.js.erb'
    else
      @nbook = Book.new
      @book = Book.find(params[:book_id])
      @comments = BookComment.where(book_id: @book.id)
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:id])
    if @comment.user_id = current_user.id
      @comment.destroy
      render 'book_comments/destroy.js.erb'
    else
      redirect_to root_path
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
