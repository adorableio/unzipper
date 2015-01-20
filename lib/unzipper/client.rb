module Unzipper
  class Client
    include HTTMultiParty

    def send_zip(file, options)
      options.validate

      response = self.class.post options[:unzipper_url], body: {
        archive: file,
        metadata: options.to_multipart_form_data
      }

      JSON.parse(response.body)
    end
  end
end
