class ClipsController < ApplicationController
  def index

    if (params[:clipname].nil?)
      if (!session[:user_id].nil?)
        redirect_to :controller => 'clips', :action => 'index', :clipname=> current_user.uid.to_s
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