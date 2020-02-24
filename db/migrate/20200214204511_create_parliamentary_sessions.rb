# frozen_string_literal: true

class CreateParliamentarySessions < ActiveRecord::Migration[6.0]
  def change
    create_table :parliamentary_sessions do |t|
      t.integer :number
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
