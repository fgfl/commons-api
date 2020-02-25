# frozen_string_literal: true

require 'pry'
class BillUsersController < ApplicationController
  def create
    updated = UpdateBillUser.call(bill_user_params)
    watchlist = User.find_by_id(bill_user_params['user_id']).bills.pluck(:id)

    if updated.fail?
      head :not_implemented
    else
      puts watchlist
      render json: {
        status: 200,
        watchlist: watchlist
      }
    end
  end

  private

  def bill_user_params
    params.require(:id).permit(:bill_id, :user_id)
  end
end
