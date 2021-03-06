require 'unzipper'

Unzipper.configure do |config|
  # ---------------------
  # The provisioned URL of the Unzipper.io service. If added through Heroku
  config.unzipper_url = ENV['UNZIPPER_URL']

  # ---------------------
  # The access key and secret key of the AWS account to use for uploading to S3
  #
  # These values are best kept outside of soource control in environment variables, and
  # so by default we'll look for them there. We highly reccomend creating an AWS role
  # that only has access to upload to the bucket you will be targeting.
  #
  # *** WARNING *** If you replace these with hard-coded values please ensure that
  # this file is NOT committed to public-facing source control.
  config.aws_access_key = ENV['AWS_UPLOADER_ACCESS_KEY']
  config.aws_secret_key = ENV['AWS_UPLOADER_SECRET_KEY']

  # ---------------------
  # The bucket to upload the unzipped artifacts to on S3
  #
  # This setting may be overridden or supplied in the call to send_zip.
  # config.s3_bucket = ""

  # ---------------------
  # The S3 region to upload the unzipped artifacts to
  #
  # Note that the value here must be the canonical region name defined by AWS, See
  # http://docs.aws.amazon.com/general/latest/gr/rande.html for specific values.
  #
  # This setting may be overridden or supplied in the call to send_zip.
  # config.s3_region = "us-west-1"

  # ---------------------
  # The S3 ACL to apply to the upploaded artifacts
  #
  # Note that the value here must be either on of the canned ACLs described at
  # http://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl or
  # a custom ACL that you have created for your bucket.
  #
  # This setting may be overridden or supplied in the call to send_zip.
  # config.s3_acl = "public-read"

  # ---------------------
  # The relative S3 root to use when uploading unzipped artifacts
  #
  # This optional setting allows you to control where in the bucket the unzipped
  # artifacts are uploaded to. For example, with the below setting uncommented
  # and a bucket com.foo.bar all contents of the unzipped archive will be uploaded
  # underneath com.foo.bar/uploads/*
  #
  # This setting may be overridden or supplied in the call to send_zip.
  # config.s3_root = "uploads"

  # ---------------------
  # The relative archive root to use when unzipping the uploaded file
  #
  # This optional setting allows you to filter which artifacts in the zip file
  # are actually uploaded to S3. For example, say you have a zip file with
  # several top-level directories of 'documents', 'movies', and 'images'
  # then using the below setting would extract and upload only the files under
  # 'images'.
  #
  # This setting may be overridden or supplied in the call to send_zip.
  # config.archive_root = "images"
end
