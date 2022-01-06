class BooksController < ApplicationController

  before_action :set_nbook

  def set_nbook
    @nbook = Book.new
  end


  def show
    @book = Book.find(params[:id])
    @ncomment = BookComment.new
    @relationship = current_user.relationships.find_by(follow_id: @book.user.id)
    @new_relationship = current_user.relationships.new
  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b|
            b.favorites.where(created_at: from...to).size <=>
            a.favorites.where(created_at: from...to).size
          }
  end

  def create
    @nbook = Book.new(book_params)
    @nbook.user_id = current_user.id
    if @nbook.save
      redirect_to book_path(@nbook), notice: "You have created book successfully."
    else
      @books = Book.all.sort_by_favorites
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end



  def update
    @book = Book.find(params[:id])
    if @book.user == current_user
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
      else
        render "edit"
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
