class UsersController < ApplicationController
  layout false

  api! 'Index method. Not much to say, rly'
  def index
    render json: User.all, status: 200
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: 200
    else
      render json: { message: "User not found" }, status: 404
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { user: { errors: user.errors } }, status: 422
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update(user_params)
      render json: user, status: 201
    else
      render json: { user: { errors: user.errors } }, status: 422
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    head 204
  end

  api! 'Only users who are old enough to party'
  # param :please, String, desc: 'Be nice', required: true
  param :manners, lambda { |value|
    value == 'please' ? true : "Be nice"
  }, required: true
  def adults
    users = User.where("age >= 18")
    render json: users, status: 200
  end

  def born_in_september
    users = User.find_by_month(9)
    render json: users, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :occupation, :birthdate)
  end
end
