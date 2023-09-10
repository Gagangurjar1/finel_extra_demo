class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :user_login]
  # ..................Create New user......................
  def index
    render json: @current_user
    # users =User.all
		# render json:users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: "User Created", data: user }
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  # ..................Login user......................
  def user_login
    if user = User.find_by(email: params[:email], password: params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check email And Password....." }
    end
  end
  
# ..................update user......................
  def update
    user = User.find(@current_user.id)
    if user.update(user_params)
      render json: { message: 'Updated successfully......', data: user }
    else
      render json: { errors: user.errors.full_messages }
    end
  end
  
  # ..................Destroy user......................
  def destroy
    user = User.destroy(@current_user.id)
    render json: { message: 'Deleted successfully', data: user }
  end
  
  # ..................Show user......................
  def show
    render json: @current_user
  end
  private
  def user_params
    params.require(:user).permit(:user_name,:email,:password, :user_type)
  end
end
