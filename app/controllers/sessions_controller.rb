class SessionsController < ApplicationController

  def new
  end

  def fb_create
  	if signed_in?
  		if current_user.email != env["omniauth.auth"].info.email
  			flash.now[:error] = 'Different email addresses, please change to match before adding FB'
      		@user = current_user
      		render 'users/edit'
      		return
      	end
  	end

  	user = User.from_omniauth(env["omniauth.auth"])
  	if user
  		sign_in user
      	redirect_back_or user
    else
    	render 'new'
    end
  end

  def create
	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end