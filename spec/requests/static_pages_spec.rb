require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit root_path
      page.should have_content('Sample App')
  	end

  end

  describe "About page" do
    it "should have the content 'About'" do
      visit about_path
      page.should have_content('About')
    end
  end
end
