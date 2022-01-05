class BookCommentsController < ApplicationController


  def create
    @book = Book.find(params[:book_id])
    @ncomment = current_user.book_comments.new(book_comment_params)
    @ncomment.book_id = @book.id
    if @ncomment.save
      flash.now[:notice] = 'You have posted the comment.'
      render :index
    else
      @nbook = Book.new
      @book = Book.find(params[:book_id])
      @comments = BookComment.where(book_id: @book.id)
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    if @comment.user_id = current_user.id
      @comment.destroy
      @book = Book.find(params[:book_id])
      render :index, alert: 'You have deleted the comment.'
    else
      redirect_to root_path
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
