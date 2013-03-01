require 'generators/initjs/resource_helpers'

module Initjs
  module Generators
    class AddGenerator < ::Rails::Generators::Base
      include Initjs::Generators::ResourceHelpers
      argument :actions, type: :array

      source_root File.expand_path('../templates', __FILE__)

      def create_files
        arguments actions.shift

        create_folders
        generate_action_files(actions) if actions.present?
      end

      private
      def arguments args
        arg = args.split(' ')
        controller = arg[0].split('/')
        @namespace_name = (controller.length > 1) ? controller[0] : ''
        @controller_name = @namespace_name.present? ? controller[1] : controller[0]
      end

      def file_path
        if @namespace_name.present?
          "#{application_path}/#{@namespace_name.underscore}/#{@controller_name.underscore}"
        else
          "#{application_path}/#{@controller_name.underscore}"
        end
      end

      def create_folders
        if @namespace_name.present?
          create_file "#{application_path}/#{@namespace_name.underscore}/.gitkip"
        end

        create_file "#{file_path}/.gitkip"
      end

      def generate_action_files actions
        actions.each do |action|
          action_file = "#{file_path}/#{action.underscore}.js.coffee"
          next if action.nil? || File.exists?(action_file)
          @action_name = action

          if @namespace_name.present?
            template "namespaced_action.coffee", action_file
          else
            template "simple_action.coffee", action_file
          end
        end
      end
    end
  end
end
