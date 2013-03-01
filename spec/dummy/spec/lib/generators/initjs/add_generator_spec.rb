require "spec_helper"

describe Initjs::Generators::AddGenerator do
  include GeneratorSpec::TestCase
  destination TMP_PATH

  describe "Creating the controller folder" do
    arguments ['Posts']

    before(:all) do
      run_generator
    end

    it "should creates the controller folder" do
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy' do
          directory 'posts'
        end
      }
    end
  end

  describe "Creating the controller with actions" do
    arguments ['Posts', 'index', 'new']

    before(:all) do
      run_generator
    end

    it "should creates the controller folder" do
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy' do
          directory 'posts'
        end
      }
    end

    it "should creates the actions files" do
      destination_root.should have_structure {
        directory 'app/assets/javascripts/dummy/posts' do
          file 'index.js.coffee' do
            contains 'Dummy.Posts.Index ='
          end

          file 'new.js.coffee' do
            contains 'Dummy.Posts.New ='
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

  before(:all) do
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

