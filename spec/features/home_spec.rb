require 'spec_helper'

feature "When access the home page", js: true do
  before do
    visit '/'
  end

  it "javascript should insert a text" do
    page.should have_content("Home index content")
  end
end
