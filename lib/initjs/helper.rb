module Initjs
  module Helper
    def initjs_tag options = {}
      options = { app_name: options } unless options.is_a?(Hash)
      id = options[:partial] && options[:partial] == true ? 'init-partial-js': 'init-js'

      content_tag 'div', '', { id: id,
                               :"data-resource" => controller.controller_path.split('/').map(&:camelize).join('/'),
                               :"data-action" => controller.action_name.camelize,
                               :"data-app-name" => options[:app_name] || "App"}
    end
  end
end

ActionView::Base.send :include, Initjs::Helper
