module Initjs
  module Generators
    module ResourceHelpers

      def application_path
        "app/assets/javascripts/#{application_name.underscore}"
      end

      def application_name
        defined?(Rails) && Rails.application ? Rails.application.class.name.split('::').first : "App"
      end

      def js_app_name
        application_name.camelize
      end

    end
  end
end
