# frozen_string_literal: true

class UsersController < InheritedResources::Base
  def create
    province = Province.where(id: params[:province])
    real_prov = province.first

    @user = real_prov.users.create(params.require(:user).permit(:username, :password, :email, :address))
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :address)
  end
end
