# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.references :session, null: false, foreign_key: true
      t.string :code
      t.string :title
      t.string :description
      t.date :introduced_date
      t.string :summary_url
      t.string :page_url
      t.string :full_text_url
      t.boolean :passed

      t.timestamps
    end
  end
end
