module Unzipper
  class InvalidOptionsError < StandardError
    attr_reader :options

    def initialize(options)
      @options = options
    end
  end
end
