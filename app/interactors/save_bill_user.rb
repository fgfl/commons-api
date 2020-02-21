class SaveBillUser
  include Interactor

  def call
    bill_id = context.bill_id
    user_id = context.user_id
    bills = Bill.includes(:user, :bill_user)
    watchlist_bill = BillUser.where(bill_id: bill_id, user_id: user_id)
    bill = Bill.find_by(id: bill_id)
    user = User.find_by(id: user_id)
    if !watchlist_bill.exists?
      bill.bill_users.create(bill_id: bill.id, user_id: user.id)
      puts "Successfully saved Bill #{bill.code} to user #{user.username}'s watchlist"
    else
      # bill.bill_users.create(bill_id: bill.id, user_id: user.id)
      BillUser.destroy_by(bill_id: bill_id, user_id: user_id)
      puts "Successfully removed #{bill.code} from user #{user.username}'s watchlist"
    end
  end
end
