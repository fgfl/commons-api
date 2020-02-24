# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :bill, null: false, foreign_key: true
      t.string :code
      t.string :title
      t.date :publication_date

      t.timestamps
    end
  end
end
