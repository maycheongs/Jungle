class SessionsController < ApplicationController
  def new; end

  def create
    @user =
      User.authenticate_with_credentials(
        params[:session][:email],
        params[:session][:password],
      )
    if @user
      log_in @user
      redirect_to :root
    else
      flash.now[:danger] = 'Invalid login'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to :root
  end
end
