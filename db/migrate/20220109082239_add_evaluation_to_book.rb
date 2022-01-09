class AddEvaluationToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :evaluation, :float
  end
end
