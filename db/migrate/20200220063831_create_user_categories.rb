class CreateUserCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_categories, id: false do |t|
      t.references :users, index: true, foreign_key: :user_id
      t.references :categories, index: true, foreign_key: :category_id

      t.timestamps null: false
    end
  end
end
