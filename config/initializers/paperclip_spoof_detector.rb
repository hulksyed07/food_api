require 'paperclip/media_type_spoof_detector'
Paperclip.options[:command_path] = '/usr/bin'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end