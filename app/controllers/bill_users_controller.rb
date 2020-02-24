# frozen_string_literal: true

class BillUsersController < ApplicationController
  def show; end

  def create
    updated = SaveBillUser.call(bill_user_params)

    if updated.sucess?
      head :ok
    else
      head :not_implemented
    end
  end

  private

  def bill_user_params
    params.require(:watchlist_bill).permit(:bill_id, :user_id)
  end
end
