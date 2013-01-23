class ClipsController < ApplicationController
  def index

    if (params[:clipname].nil?)
      #session[:user_id]=nil
      if (!session[:user_id].nil?) # do not make new clip if signed to facebook
        redirect_to :controller => 'clips', :action => 'index', :clipname=> Clip.clip_name_from_user(current_user)
        return
      end

      if(!cookies[:clipname].nil?)
        redirect_to :controller => 'clips', :action => 'index', :clipname=> cookies[:clipname]
        return
      end

      @clip=Clip.next_clip
      redirect_to :controller => 'clips', :action => 'index', :clipname=> @clip.name

      #@clip=Clip.save_empty_paste(newname)
      params[:name]=@clip.name
      # save cookie for next time
      # Set a simple session cookie

      return
    else
      @clip=Clip.find(:all, :conditions => [ "name = ?", params[:clipname]]).first
      cookies[:clipname] = @clip.name
    end
  end
  # how to build a view model instead of modelf
end
