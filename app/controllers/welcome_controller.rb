class WelcomeController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to success_path

      unless @user.phone_no.nil?
        @user.send_text
      end

      unless @user.email.nil?
        @user.send_email
      end
    else
      redirect_to success_path, notice: "There was an error. Please try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone_no)
  end
end
