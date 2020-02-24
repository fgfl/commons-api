# frozen_string_literal: true

class DestroyBillUser
  include Interactor

  def call
    def call
      bill_id = context.bill_id
      user_id = context.user_id
      watchlist_bill = BillUser.where(bill_id: bill_id, user_id: user_id)
      puts 'Successfully removed!!'
      wBillUser.destroy(watchlist_bill.id)
    end
  end
end
