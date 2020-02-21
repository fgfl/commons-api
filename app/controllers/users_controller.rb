class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
               users: @users,
             }
    else
      render json: {
               status: 500,
               errors: ["no users found"],
             }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: {
        user: @user,
      }
    else
      render json: {
        status: 500,
        errors: ["user not found"],
      }
    end
  end

  def create
    # raise user_params.inspect
    result = SaveUserAndCategories.call(user_params)
    @user = result.user

    if result.success?
      login!
      render json: {
               status: :created,
               user: @user,
             }
    else
      render json: {
        status: 500,
        errors: result.message,
      }
    end
  end

  def update
    @user = User.find_by_id(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params[:user].delete(:postal_code) if params[:user][:postal_code].blank?
    params[:user].delete(:sms_notification) if params[:user][:sms_notification].blank?
    params[:user].delete(:email_notification) if params[:user][:email_notification].blank?
    params[:user].delete(:phone_number) if params[:user][:phone_number].blank?

    if @user == current_user
      pp @user
      pp user_params
      @user.update!(user_params)
      render json: {
        status: 200,
        user: @user,
      }
    else
      render json: {
        status: 500,
        errors: ["Error updating user."],
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :postal_code, :sms_notification, :email_notification, :phone_number, :categories => [])
  end
end
