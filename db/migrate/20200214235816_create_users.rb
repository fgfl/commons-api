class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :phone_number
      t.string :postal_code
      t.boolean :email_notification
      t.boolean :sms_notification

      t.timestamps
    end
  end
end
