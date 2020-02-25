# frozen_string_literal: true

class UpdateBillUser
  include Interactor

  def call
    if bill_id = context.bill_id
      user_id = context.user_id
      watchlist_bill = BillUser.where(bill_id: bill_id, user_id: user_id)
      # bill = Bill.find_by(id: bill_id)
      # user = User.find_by(id: user_id)
      if !watchlist_bill.exists?
        BillUser.create(bill_id: bill_id, user_id: user_id)
        puts "Successfully saved Bill ID: #{bill_id} to user ID: #{user_id} watchlist"
      else
        BillUser.destroy_by(bill_id: bill_id, user_id: user_id)
        puts "Successfully removed Bill ID: #{bill_id} from user ID: #{user_id} watchlist"
      end
    else
      context.fail!(message: 'Updated watchlist failure!')
    end
  end
end
