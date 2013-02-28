module Initjs
  module Helper
    def initjs_tag options = {}
      content_tag 'div', '', { :id => "init-js",
                               :"data-controller-class" => controller.class.name,
                               :"data-controller-name" => controller.controller_name.camelize,
                               :"data-action" => controller.action_name.camelize,
                               :"data-app-name" => options[:app_name] || "App"}
    end
  end
end

ActionView::Base.send :include, Initjs::Helper
