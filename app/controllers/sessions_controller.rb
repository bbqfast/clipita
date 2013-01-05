class SessionsController < ApplicationController
  def create
    auth = env["omniauth.auth"]
    params[:debug] = auth.to_s
    Mylog.log.info("AUTH=" + auth.to_s)
    Mylog.log.info("PARAM=" + env["omniauth.params"].to_s)

    ouser = Ouser.from_omniauth(auth)
    Mylog.log.info('email='+auth.info.email)
    Mylog.log.info('first='+auth.info.first_name)
    Mylog.log.info('last='+auth.info.last_name)

    user1 = User.new(:email => auth.info.email, :first => auth.info.first_name, :last => auth.info.last_name)
    user1.save
    Mylog.log.info('saved user id=' + user1.id.to_s)


    session[:user_id] = ouser.id

    if (!params[:clipname].nil?)
      Mylog.log.info('session clipname=' + params[:clipname])
    end

    clip4=Clip.find(:all, :conditions => [ "name = ?", params[:clipname]]).first
    Clip.create_with_content(ouser.uid.to_s, clip4.paste, user1.id ) if (!clip4.nil?)

    # redirect_to root_url
    redirect_to :controller => 'clips', :action => 'index', :clipname=>ouser.uid.to_s
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

