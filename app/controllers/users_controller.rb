class UsersController < InheritedResources::Base

  def new
    @user = User.create(params.require(:user).permit(:username, :password, :email, :province))
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end
  private

    def user_params
      params.require(:user).permit(:username, :password, :email, :provinces_id)
    end

end
