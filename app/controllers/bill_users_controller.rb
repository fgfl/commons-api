# frozen_string_literal: true

class BillUsersController < ApplicationController
  def create
    updated = SaveBillUser.call(bill_user_params)

    if updated.fail?
      head :not_implemented
    else
      head :ok
    end
  end

  private

  def bill_user_params
    params.require(:id).permit(:bill_id, :user_id)
  end
end
