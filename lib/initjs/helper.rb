module Initjs
  module Helper
    def initjs_tag options = {}
      options = { app_name: options } unless options.is_a?(Hash)
      if options[:partial] && options[:partial] == true
        id = 'init-partial-js'
      else
        id = 'init-js'
      end

      content_tag 'div', '', { id: id,
                               :"data-controller-class" => controller.class.name,
                               :"data-controller-name" => controller.controller_name.camelize,
                               :"data-action" => controller.action_name.camelize,
                               :"data-app-name" => options[:app_name] || "App"}
    end
  end
end

ActionView::Base.send :include, Initjs::Helper
