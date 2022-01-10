class CreateBookTags < ActiveRecord::Migration[5.2]
  def change
    create_table :book_tags do |t|
      t.references :book, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
