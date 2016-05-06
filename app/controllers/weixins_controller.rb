class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # before_filter :check_weixin_legality
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
      render "echo", :formats => :xml
    end
  end

  # private
  #   def check_weixin_lagality
  #     array = [Rails.configuration.weixin_token,params[:timestamp],params[:nonce]].sort
  #     render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  #   end
end