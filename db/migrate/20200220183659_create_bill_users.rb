class CreateBillUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_users do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
