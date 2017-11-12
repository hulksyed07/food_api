module V1
  class ProfilesController < ApplicationController
    def update_avatar
      if current_user.update(avatar: decode_base64)
        current_user.avatar
      else
        puts "Some error occurred"
      end
    end

    private

    def decode_base64
      # decode base64 string
      # Rails.logger.info 'decoding base64 file'
      # byebug
      # decoded_data = Base64.decode64(avatar_params[:base64])
      # byebug
      # File.open("#{Rails.root}/tmp/shipping_label.png", 'wb') do|f|
      #   f.write(Base64.decode64(avatar_params[:base64]))
      # end
      # byebug
      # decoded_data = Paperclip.io_adapters.for(avatar_params)
      # decoded_data = Paperclip.io_adapters.for("data:image/jpeg\;base64," + avatar_params[:base64])
      data = Paperclip.io_adapters.for("data:image/jpeg\;base64," + avatar_params[:base64])
      # create 'file' understandable by Paperclip
      # data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end

      # set file properties
      data.content_type = avatar_params[:filetype]
      data.original_filename = avatar_params[:filename]
      # byebug
      # return data to be used as the attachment file (paperclip)
      data
    end

    def avatar_params
      params[:avatar].permit(:filename, :filetype, :filesize, :base64)
    end

  end
end