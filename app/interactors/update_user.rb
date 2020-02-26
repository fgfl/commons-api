# frozen_string_literal: true

class UpdateUser
  include Interactor

  def call
    user = context.user_to_update
    user_params = context.user_params
    categories = user_params.delete(:categories)

    user.update!(user_params)

    context.user = user
    context.categories = categories
  end
end
