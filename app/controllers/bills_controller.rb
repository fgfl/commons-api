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

  def show
    @user_bills = User.find_by_id(bill_params.to_i).bills.all.pluck(:id)

    if @user_bills
      render json: {
        user_bills: @user_bills
      }
    else
      render json: {
        status: 500,
        errors: ['no user_bills found']
      }
    end
  end

  private

  def bill_params
    params.require(:id)
  end
end
