class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash[:danger] = 'SORRY, Invalid email / password combination'
      render :new
    end
  end

  def destroy
    #code
  end
end
