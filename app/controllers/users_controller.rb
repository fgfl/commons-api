class UsersController < ApplicationController

  def create
    puts user_params.inspect
    result = CreateUser.call(user_params)

    if result.success?
      session[:user_token] = result.token
    else
      puts "User signup error!"
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :email_notification, :sms_notification, :phone_number)
  end
end
