class SessionsController < ApplicationController
  def create
    #xxx
    ouser = Ouser.from_omniauth(env["omniauth.auth"])
    session[:user_id] = ouser.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def omniauth_failure
    redirect_to root_url
    #redirect wherever you want.
  end
end

