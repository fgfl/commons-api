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
        errors: result.message  
      }
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    puts "user:"
    pp @user
    puts "current_user"
    pp current_user
    puts "session:"
    pp session[params[:id]]
    pp params.inspect
    if @user == current_user
      @user.update(user_params)
      render json: {
        status: 200,
        user: @user,
      }
    else
      render json: {
        status: 500,
        errors: @user.errors.full_messages,
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :sms_notification, :email_notification, :phone_number, :categories => [])
  end
end
