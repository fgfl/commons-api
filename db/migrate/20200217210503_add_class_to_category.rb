# frozen_string_literal: true

class AddClassToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :uclassify_class, :string
  end
end
