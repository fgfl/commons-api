# frozen_string_literal: true

class BillsController < ApplicationController
  def index
    # Adds categories to bills by category_id as array
    @bills = ReturnBillsWithCategories.call

    if @bills
      render json: {
        bills: @bills.bills,
        categories: @bills.categories
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end
end
