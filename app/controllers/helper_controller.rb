class HelperController < ApplicationController
  def ajaxsave
    clip2=Clip.new
    @clip = Clip.find(params[:clipid])
    @clip.paste = params[:cliptext]
    @clip.save
    
    respond_to do |format|
      format.html { render json: clip2 }
      format.json { render json: clip2 }
    end
  end

  def ajaxload
    @clip = Clip.find(params[:clipid])

    respond_to do |format|
      format.html { render json: @clip }
      format.json { render json: @clip.as_json }
    end
  end
end