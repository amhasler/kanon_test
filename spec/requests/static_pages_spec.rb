require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Project Page One'" do
      visit '/static_pages/home'
      expect(page).to have_content('Project Page One')
    end

    it "should have the right title" do
		  visit '/static_pages/home'
		  expect(page).to have_title("Project Page One | Home")
		end
  end

  describe "About page" do

  	it "should have the content 'Project Page One'" do
      visit '/static_pages/about'
      expect(page).to have_content('About the project')
    end

    it "should have the right title" do
		  visit '/static_pages/about'
		  expect(page).to have_title("Project Page One | About")
		end
	end

end
