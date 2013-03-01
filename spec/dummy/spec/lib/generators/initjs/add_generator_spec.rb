require "spec_helper"

describe Initjs::Generators::AddGenerator do
  include GeneratorSpec::TestCase
  destination TMP_PATH

  describe "Creating the controller folder" do
    arguments ['projects']

    before do
      run_generator
    end

    it "should creates the controller folder" do
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy' do
          directory 'projects'
        end
      }
    end
  end

  describe "Creating the controller with actions" do
    arguments ['projects', 'index', 'new']

    before do
      run_generator
    end

    it "should creates the controller folder" do
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy' do
          directory 'projects'
        end
      }
    end

    it "should creates the actions files" do
      run_generator
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy/projects' do
          file 'index.js.coffee' do
            contains 'Dummy.Projects.Index ='
          end

          file 'new.js.coffee' do
            contains 'Dummy.Projects.New ='
          end
        end
      }
    end
  end
end

describe Initjs::Generators::AddGenerator, "Creating the controller with namespace folders, without actions" do
  include GeneratorSpec::TestCase
  destination TMP_PATH
  arguments ['Blog/Posts']

  before do
    run_generator
  end

  it "should creates the namespace folder" do
    destination_root.should have_structure {
      directory 'app/assets/javascripts/dummy' do
        directory 'blog'
      end
    }
  end

  it "should creates the controller folder inside the namespace folder" do
    destination_root.should have_structure {
      directory 'app/assets/javascripts/dummy/blog' do
        directory 'posts'
      end
    }
  end
end

