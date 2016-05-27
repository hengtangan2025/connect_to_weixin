module ReplyWeixinMessageHelper
  def reply_text_message(from=nil, to=nil, content)
    message = TextReplyMessage.new
    message.FromUserName = from || @weixin_message.ToUserName
    message.ToUserName   = to   || @weixin_message.FromUserName
    message.Content      = content
    encrypt_message message.to_xml
  end

  private

    def encrypt_message(msg_xml)
      return msg_xml if !@is_encrypt
      # 加密回复的XML
      encrypt_xml = Prpcrypt.encrypt(@weixin_public_account.aes_key, msg_xml, @weixin_public_account.app_id).gsub("\n","")
      # 标准的回包
      generate_encrypt_message(encrypt_xml)
    end

    def generate_encrypt_message(encrypt_xml)
      msg              = EncryptMessage.new
      msg.Encrypt      = encrypt_xml
      msg.TimeStamp    = Time.now.to_i.to_s
      msg.Nonce        = SecureRandom.hex(8)
      msg.MsgSignature = generate_msg_signature(encrypt_xml, msg)
      msg.to_xml
    end 
end