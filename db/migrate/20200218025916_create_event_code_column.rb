# frozen_string_literal: true

class CreateEventCodeColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :code, :string
  end
end
