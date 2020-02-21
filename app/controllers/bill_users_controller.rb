class BillUsersController < ApplicationController

  def create
    SaveBillUser.call(bill_user_params)
  end

  # def update
  #   DestroyBillUser.call(bill_user_params)
  # end

  private

  def bill_user_params
    params.require(:watchlist_bill).permit(:bill_id, :user_id)
  end
end
