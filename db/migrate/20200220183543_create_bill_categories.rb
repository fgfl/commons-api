class CreateBillCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_categories do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
