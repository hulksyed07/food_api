module V1
  class ProfilesController < ApplicationController
    def update_avatar
      current_user.avatar = decode_base64
      if current_user.save
        current_user.avatar
      else
        puts "Some error occurred"
      end
    end

    private

    def decode_base64
      # decode base64 string
      Rails.logger.info 'decoding base64 file'
      byebug
      decoded_data = Base64.decode64(params[:avatar][:base64])
      # create 'file' understandable by Paperclip
      data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end

      # set file properties
      data.content_type = params[:avatar][:filetype]
      data.original_filename = params[:avatar][:filename]
      byebug
      # return data to be used as the attachment file (paperclip)
      data
    end

  end
end