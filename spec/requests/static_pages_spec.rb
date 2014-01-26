require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Project Page One |" }

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Project Page One') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "About page" do

    before { visit '/about' }

  	it { should have_content('About the project') }
    it { should have_title(full_title('About')) }
	end

	describe "Contact page" do

    before { visit '/contact' }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end

end
