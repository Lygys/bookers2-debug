class Book < ApplicationRecord
	is_impressionable
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
	has_many :book_comments, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags


	scope :sort_books, -> (sort) { order(sort[:sort]) }
  scope :sort_list, -> {
    {
      "並び替え" => "",
      "評価の高い順" => "evaluation DESC",
      "新着順" => "created_at DESC"
    }
  }

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  def self.sort_by_favorites
	  select('books.*', 'count(favorites.id) AS favs')
	  .left_joins(:favorites)
	  .group('books.id')
	  .order('favs desc')
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
