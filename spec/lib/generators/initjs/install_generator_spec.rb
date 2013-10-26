require "spec_helper"

describe Initjs::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination TMP_PATH

  before(:all) do
    copy_file "#{DUMMY_PATH}/app/assets/javascripts/application.sample.js", "#{TMP_PATH}/app/assets/javascripts/application.js"
    run_generator
  end

  it "should inject requires for app file and initjs" do
    destination_root.should have_structure {
      directory 'app/assets/javascripts' do
        file 'application.js' do
          contains '//= require dummy/dummy.js'
          contains '//= require init.js'
        end
      end
    }
  end

  it "should create app file" do
    destination_root.should have_structure {
      directory 'app/assets/javascripts' do
        directory 'dummy' do
          file 'dummy.js.coffee' do
            contains '#= require_self'
            contains '#= require_tree .'
            contains 'window.Dummy ='
          end
        end
      end
    }
  end
end
