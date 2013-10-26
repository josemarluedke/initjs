require 'spec_helper'

shared_examples "posts feature" do
  context "When access the index posts page" do
    before do
      click_link "Posts#index"
    end

    it "javascript should insert a text" do
      page.should have_content("Posts index content")
    end
  end

  context "When access the new posts page" do
    before do
      click_link "Posts#new"
    end

    it "javascript should insert a text" do
      page.should have_content("Posts new content")
    end
  end

  context "When access the show posts page" do
    before do
      click_link "Posts#show"
    end

    it "javascript should insert a text" do
      page.should have_content("Posts show content")
    end
  end
end

describe "Posts without turbolinks", js: true do
  before do
    visit '/'
  end
  it_behaves_like "posts feature"
end

describe "Posts with turbolinks", js: true do
  before do
    visit '/?turbolinks=true'
  end
  it_behaves_like "posts feature"
end
