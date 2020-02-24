# frozen_string_literal: true
# require "pry"

class BillUsersController < ApplicationController
  def show; end

  def create
    updated = SaveBillUser.call(bill_user_params)
    # binding.pry

    if updated.fail?
      head :not_implemented
    else
      head :ok
    end
  end

  private

  def bill_user_params
    params.require(:watchlist_bill).permit(:bill_id, :user_id)
  end
end
