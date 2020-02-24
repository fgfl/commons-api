# frozen_string_literal: true

class FormatCode
  include Interactor
  # Called by write_to_db organizer
  # Splits the code into its own field to identify Bills and Events
  # Removes the comma and space

  # Note: 'bill_code' is a temporary key to avoid conflicting hash keys.
  # It is later renamed to simply 'code' in the Events table

  def call
    items = context.data
    items.each do |item|
      bill_code = item['title'].split(', ').first
      item['title'].sub! /\A.+?(?=, )/mi, ''
      item['description'].sub! /\A.+?(?=, )/mi, ''
      item['title'].slice!(0, 2)
      item['description'].slice!(0, 2)
      item['code'] = bill_code
      item['bill_code'] = bill_code
    end

    context.data = items
  end
end
