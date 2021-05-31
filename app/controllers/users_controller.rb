class UsersController < ApplicationController

  def show
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in_user @user
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :name )
  end
end
