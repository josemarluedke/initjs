require "spec_helper"
require File.expand_path("../../../../../../../lib/generators/initjs/install/install_generator.rb", __FILE__)

describe Initjs::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../../../../../tmp", __FILE__)

  before do
    run_generator
  end

  specify do
    destination_root.should have_structure {
      directory 'app/assets/javascripts' do
        file 'application.js' do
          contains '//= require dummy/dummy.js'
          contains '//= require init.js'
        end

        directory 'dummy' do
          file 'dummy.js.coffee'
        end
      end
    }
  end
end
