class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

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
