class CreateBillCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_categories, id: false do |t|
      t.references :bills, index: true, foreign_key: :bill_id
      t.references :categories, index: true, foreign_key: :category_id

      t.timestamps null: false
    end
  end
end
