module Unzipper
  # Used to srtup and modify settings for the Unzipper service client
  class Configuration
    OPTIONS = [:aws_access_key, :aws_secret_key, :unzipper_url, :s3_region,
               :s3_root, :s3_bucket, :s3_acl, :archive_root].freeze

    REQUIRED_OPTIONS = [:aws_access_key, :aws_secret_key, :unzipper_url, :s3_region,
                        :s3_bucket, :s3_acl].freeze

    # The Unzipper service URL provisioned for your application
    attr_accessor :unzipper_url

    # The AWS S3 access key with write access ot the bucket you wish to upload to
    attr_accessor :aws_access_key

    # The AWS S3 secret key with write access ot the bucket you wish to upload to
    attr_accessor :aws_secret_key

    # The AWS S3 region containing the bucket to upload to
    attr_accessor :s3_region

    # The AWS S3 bucket to upload to
    attr_accessor :s3_bucket

    # The directory, relative to the bucket root, to use as a relative root when uploading
    attr_accessor :s3_root

    # The AWS S3 ACL to set on uploaded files
    #
    # This field is a string that may be a canned ACL or a custom one.
    #
    # @see http://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html
    attr_accessor :s3_acl

    # The directory, relative to the root of the zip archive, to use as a relative root
    # when determining which files to upload to S3
    attr_accessor :archive_root

    def initialize
      @unzipper_url   = ""
      @aws_access_key = ""
      @aws_secret_key = ""
      @s3_region      = ""
      @s3_bucket      = ""
      @s3_root        = nil
      @s3_acl         = ""
      @archive_root   = nil
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end

    def []=(option, value)
      setter = (option.to_s + "=").to_sym
      send(setter, value)
    end

    # Returns a hash of all configuration options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash[option.to_sym] = self.send(option)
        hash
      end
    end

    # Returns a hash of all configurable options merged with +hash+
    #
    # @param [Hash] hash A set of configuration options that will take precendence over the defaults
    def merge(hash)
      merged_config = self.clone
      hash.each do |key, value|
        merged_config[key] = value
      end
      merged_config
    end

    # Determines if the unzipper if fully configured and ready to send to the service
    def validate
      REQUIRED_OPTIONS.each do |option|
        if self[option].nil? || self[option].empty?
          raise InvalidOptionsError.new(self), "missing required option '#{option.to_s}'"
        end
      end
    end

    # Formats the configuration as a hash that can be submitted as the metadata portion
    # of the multipart form along with the zip file
    def to_multipart_form_data
      metadata = {
        awsAuth: {
          accessKey: aws_access_key,
          secretKey: aws_secret_key
        },
        s3Config: {
          region: s3_region,
          bucket: s3_bucket,
          permissions: s3_acl
        }
      }

      if archive_root
        metadata[:archiveConfig] = {root: archive_root}
      end

      if s3_root
        metadata[:s3Config][:root] = s3_root
      end

      metadata
    end

    # Output the current configuration as a String
    def to_s
      prefix = "<Unzipper::Configuration "
      postfix = ">"
      fields = OPTIONS.map{|opt| opt.to_s+"=\""+self.send(opt)+"\""}.join(" ")
      prefix + fields + postfix
    end
  end
end
