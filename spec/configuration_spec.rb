require 'spec_helper'

describe Unzipper::Configuration do
  describe '.initialize' do
    it 'sets default values' do
      config = Unzipper::Configuration.new

      config[:unzipper_url].must_be_empty
      config[:aws_access_key].must_be_empty
      config[:aws_secret_key].must_be_empty
      config[:s3_region].must_be_empty
      config[:s3_bucket].must_be_empty
      config[:s3_acl].must_be_empty
      config[:s3_root].must_be_nil
      config[:archive_root].must_be_nil
    end
  end

  describe '#merge' do
    it 'creates a new configuration instance' do
      config = Unzipper::Configuration.new
      new_config = config.merge({})
      new_config.wont_be_same_as config
    end

    it 'overwrites existing values with new values' do
      config = Unzipper::Configuration.new

      config[:s3_region] = 'us-west-1'
      config[:s3_acl] = 'public-read'

      new_config = config.merge(s3_region: 'us-east-2')

      new_config[:s3_region].must_equal 'us-east-2'
    end

    it 'retains values that are not specified in the override hash' do
      config = Unzipper::Configuration.new

      config[:s3_region] = 'us-west-1'
      config[:s3_acl] = 'public-read'

      new_config = config.merge(s3_region: 'us-east-2')

      new_config[:s3_acl].must_equal 'public-read'
    end
  end

  describe '#validate' do
    before(:each) do
      @config = Unzipper::Configuration.new.tap do |c|
        c.aws_access_key = '123456abc'
        c.aws_secret_key = '654321xyz'
        c.unzipper_url   = 'http://api.unzipper.io'
        c.s3_region      = 'us-west-1'
        c.s3_bucket      = 'io.adorable.swip'
        c.s3_acl         = 'public-read'
      end
    end

    it 'returns true if no errors were encountered' do
      @config.validate.must_equal true
    end

    it 'raises an error when a required option is missing or empty' do
      Unzipper::Configuration::REQUIRED_OPTIONS.each do |required_option|
        nilled_config = @config.merge(required_option => nil)
        proc { nilled_config.validate }.must_raise Unzipper::InvalidOptionsError

        empty_config = @config.merge(required_option => "")
        proc { empty_config.validate }.must_raise Unzipper::InvalidOptionsError
      end
    end
  end
end
