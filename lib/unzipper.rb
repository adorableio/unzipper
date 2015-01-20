require 'httmultiparty'
require 'unzipper/errors'
require 'unzipper/client'
require 'unzipper/configuration'
require 'unzipper/version'

module Unzipper
  class << self

    # Sends a zip file to Unziopper for processing and uploading to S3
    def send_zip(file, options)
      Client.send_zip file, configuration.merge(options)
    end

    # An Unzipper configuration object
    attr_writer :configuration

    # Call this method to modify defaults in your initializers
    #
    # @example
    #   Unzipper.configure do |config|
    #     config.aws_access_key = ENV['AWS_UPLOADER_ACCESS_KEY']
    #     config.aws_secret_key = ENV['AWS_UPLOADER_SECRET_KEY']
    #   end
    def configure
      yield configuration
    end

    # The configuration object
    # @see Unzipper.configure
    def configuration
      @configuration ||= Configuration.new
    end
  end
end
