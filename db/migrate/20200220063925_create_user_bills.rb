class CreateUserBills < ActiveRecord::Migration[6.0]
  def change
    create_table :user_bills, id: false do |t|
      t.references :users, index: true, foreign_key: :user_id
      t.references :bills, index: true, foreign_key: :bill_id

      t.timestamps null: false
    end
  end
end
