module Initjs
  module Generators
    class InitjsGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        copy_file "app.js.coffee", "app/assets/javascripts/app.js.coffee"
      end
    end
  end
end
