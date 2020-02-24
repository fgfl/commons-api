# frozen_string_literal: true

class BillUsersController < ApplicationController
  def index
    @user_bills = User.find_by_id(bill_user_params[:user_id]).bills.all.pluck(:id)

    if @events
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
