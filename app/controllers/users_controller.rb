class UsersController < ApplicationController
  layout false

  def_param_group :user do
    param :user, Hash, desc: 'User\'s params', required: true do
      param :name, String, desc: 'Name', required: true
      param :age, lambda { |value| !!(value =~ /\A\d+\z/) }, 
            desc: 'Must be an integer',
            required: true
      param :occupation, String, desc: 'User\'s occupation', required: true
      param :birthdate, String, desc: 'User\'s birthdate'
    end
  end

  api! 'Index method. Not much to say, rly'
  def index
    render json: User.all, status: 200
  end
  
  api! 'Show method for user'
  param :id, String, desc: 'User\'s id', required: true
  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: 200
    else
      render json: { message: "User not found" }, status: 404
    end
  end

  api! 'Creates user'
  error code: 422, desc: 'Unprocessable entity'
  param :user, Hash, desc: 'User\'s params', required: true do
    param :name, String, desc: 'Name', required: true
    param :age, lambda { |value| !!(value =~ /\A\d+\z/) }, 
          desc: 'Must be an integer',
          required: true
    param :occupation, String, desc: 'User\'s occupation', required: true
    param :birthdate, Date, desc: 'User\'s birthdate'
  end
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { user: { errors: user.errors } }, status: 422
    end
  end

  api! 'Updates user'
  param :id, String, desc: 'User\'s ID'
  param_group :user
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
