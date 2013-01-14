class ClipsController < ApplicationController
  def index

    if (params[:clipname].nil?)
      #session[:user_id]=nil
      if (!session[:user_id].nil?) # do not make new clip if signed to facebook
        redirect_to :controller => 'clips', :action => 'index', :clipname=> Clip.clip_name_from_user(current_user)
      end

      @clip=Clip.next_clip
      #@clip=Clip.save_empty_paste(newname)
      params[:name]=@clip.name
    else
      @clip=Clip.find(:all, :conditions => [ "name = ?", params[:clipname]]).first
    end
  end
  # how to build a view model instead of modelf
end
