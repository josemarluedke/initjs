require 'spec_helper'

shared_examples "blog posts feature" do
  context "When access the index posts page" do
    before do
      click_link "PostsBlog#index"
    end

    it "javascript should insert a text" do
      page.should have_content("Blog::Posts index content")
    end
  end

  context "When access the new posts page" do
    before do
      click_link "PostsBlog#new"
    end

    it "javascript should insert a text" do
      page.should have_content("Blog::Posts new content")
    end
  end

  context "When access the show posts page" do
    before do
      click_link "PostsBlog#show"
    end

    it "javascript should insert a text" do
      page.should have_content("Blog::Posts show content")
    end
  end
end

describe "Blog posts without turbolinks", js: true do
  before do
    visit '/'
  end
  it_behaves_like "blog posts feature"
end

describe "Blog posts with turbolinks", js: true do
  before do
    visit '/?turbolinks=true'
  end
  it_behaves_like "blog posts feature"
end
