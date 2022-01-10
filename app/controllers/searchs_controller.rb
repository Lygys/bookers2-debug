class SearchsController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @results = search_for(@model, @content, @method)
    if @model == "User"
      @relationship = current_user.relationships.find_by(follow_id: @results.ids)
      @new_relationship = current_user.relationships.new
    end
  end

  private
  def search_params
    params.require(:search).permit(:model, :content, :method)
  end


  def search_for(model, content, method)
    if @model == "User"
      if @method == "perfect"
        User.where(name: content)
      elsif @method == "partial"
        User.where('name LIKE ?', '%'+content+'%')
      elsif @method == "forward"
        User.where('name LIKE ?', content+'%')
      elsif @method == "backward"
        User.where('name LIKE ?', '%'+content)
    end
    elsif @model == "Book"
      if @method == "perfect"
        Book.where(title: content)
      elsif @method == "partial"
        Book.where('title LIKE ?', '%'+content+'%')
      elsif @method == "forward"
        Book.where('title LIKE ?', content+'%')
      elsif @method == "backward"
        Book.where('title LIKE ?', '%'+content)
    end
    elsif @model == "Tag"
      if method == 'perfect'
        tags = Tag.where(name: content)
      elsif method == 'forward'
        tags = Tag.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        tags = Tag.where('name LIKE ?', '%' + content)
      else
        tags = Tag.where('name LIKE ?', '%' + content + '%')
      end
      return tags.inject(init = []) {|result, tag| result + tag.books}
    else
      redirect_to request.referer
    end
  end
end
