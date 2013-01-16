class UsersController < ApplicationController
  def index
    fill_ouser
  end

  #
  def fill_ouser
    @user = User.new

    auth = env["omniauth.auth"]
    if (!auth.nil?)
      #Mylog.log.info("AUTH=" + auth.to_s)
      #Mylog.log.info("PARAM=" + env["omniauth.params"].to_s)

      ouser = Ouser.from_omniauth(auth)
      Mylog.log.info('ouserid = ' + ouser.id.to_s)

      # if via facebook sign-in and user already has an account
      # log in the user instead of showing registration page
      if (!auth.info.nil?)
        user2 = User.find_by_ouser_id(ouser.id)
        if (!user2.nil?)
        Mylog.log.info('FOUND login = ' + user2.email)
          session[:user_id] = user2.id
          redirect_to :controller => 'clips', :action => 'index', :notice => "Logged in!"
        end

        @user.email = auth.info.email
        @user.first = auth.info.first_name
        @user.last = auth.info.last_name
        @user.ouser_id = ouser.id

        Mylog.log.info('email='+auth.info.email)
        Mylog.log.info('first='+auth.info.first_name)
        Mylog.log.info('last='+auth.info.last_name)
      end
    end
    return @user
  end

  def create
   invalid=false
    invalid = check_empty(params[:user][:first], 'first')
    invalid = check_empty(params[:user][:last], 'last')
    invalid = check_empty(params[:user][:email], 'email')

    if invalid
      render 'index'
    end

    #user1 = User.new(params[:user][:email], params[:user][:first], params[:user][:lsat])
    user1 = User.new(params[:user])

    clipname = Clip.clip_name_from_user(user1)

    if user1.save
      # copy from sessions
      Clip.create_with_content(clipname, "new content", user1.id )
      session[:user_id] = user1.id
      # redirect_to root_url
      redirect_to :controller => 'clips', :action => 'index', :clipname=>clipname
    else
      
    end
  end

  def check_empty(entry, label)
    if (entry == '')
      @error_text[label]='required'
      return true
    else
      return false
    end
  end


end
