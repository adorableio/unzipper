require 'spec_helper'

describe Unzipper::Configuration do
  it '.initialize sets default values' do
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
