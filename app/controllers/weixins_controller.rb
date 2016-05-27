class WeixinsController < ApplicationController
  def show
    token = "kc_courses"
    array = [token,params[:timestamp],params[:nonce]].sort
    if params[:signature] != Digest::SHA1.hexdigest(array.join)
      render :text => "Forbidden", :status => 403
    else
      render :text => params[:echostr]
    end
  end

  def create
    token = "kc_courses"
    array = [token,params[:timestamp],params[:nonce]].sort
    if params[:signature] != Digest::SHA1.hexdigest(array.join)
      render :text => "Forbidden", :status => 403
    else
      render :text => params[:echostr]
    end


    if params[:xml][:MsgType] == "text"
      p params[:xml][:content]
      render "echo", :formats => :xml
    end
  end

  def echo
    
  end

  # private
  #   def check_weixin_lagality
  #     array = ["kc_courses",params[:timestamp],params[:nonce]].sort
  #     render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  #   end
end