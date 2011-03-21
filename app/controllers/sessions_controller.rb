class SessionsController < ApplicationController

  def new
	if facebook_session
		redirect_to current_user
	end
    @title = "Sign in"
  end
  
  def facebook_session
	if current_facebook_user
		id = current_facebook_user.id
		user = User.where(:fb_id => id)
		if user.empty?
			return false
		else
			sign_in user[0]
			return true
		end
	end
	return false
  end
  
  def create

    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
