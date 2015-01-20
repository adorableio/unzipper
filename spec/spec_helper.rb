$:.unshift File.join(__dir__, '..', 'lib')
$:.unshift File.join(__dir__, '..', 'spec')

require 'minitest/spec'
require 'minitest/autorun'
require 'unzipper'
