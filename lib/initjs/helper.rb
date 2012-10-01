module Initjs
  module Helper
    def initjs_tag
      content_tag 'div', '', { :id => "init-js",
                                :"data-controller-class" => controller.class.name,
                                :"data-controller-name" => controller.controller_name.camelize,
                                :"data-action" => controller.action_name.camelize }
    end
  end
end

ActionView::Base.send :include, Initjs::Helper
