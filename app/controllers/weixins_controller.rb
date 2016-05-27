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
      p params[:xml][:Content]
      # xml_data = "<xml>
      # <ToUserName><![CDATA[<%= params[:xml][:FromUserName] %>]]></ToUserName>
      # <FromUserName><![CDATA[<%= params[:xml][:ToUserName] %>]]></FromUserName>
      # <CreateTime><%= Time.now.to_i %></CreateTime>
      # <MsgType><![CDATA[text]]></MsgType>
      # <Content><![CDATA[大山的回声：<%= params[:xml][:Content] %>]]></Content>
      # <FuncFlag>0</FuncFlag>
      # </xml>"
      # respond_to do |format|
      #   format.xml {render xml: xml_data}
      # end
    end
  end

  def echo
    
  end

  # private
  #   def check_weixin_lagality
  #     array = [Rails.configuration.weixin_token,params[:timestamp],params[:nonce]].sort
  #     render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  #   end
end