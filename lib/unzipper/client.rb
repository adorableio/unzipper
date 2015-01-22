module Unzipper
  class Client
    include HTTMultiParty

    class << self
      def send_zip(file, options)
        options.validate

        post options[:unzipper_url], body: {
          archive: file,
          metadata: options.to_multipart_form_data.to_json
        }
      end
    end
  end
end
