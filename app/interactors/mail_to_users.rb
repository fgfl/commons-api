class MailToUsers
  include Interactor::Organizer

  organize MailGetUserBills, MailGetUserCategories
end
