module Unzipper
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), '.', 'templates')

    def create_template
      template 'initializer.rb', 'config/initializers/unzipper.rb'
    end

    def finish
      puts ""
      puts "You're all set! Open config/initializers/unzipper.rb and configure for your application."
      puts ""
    end
  end
end
