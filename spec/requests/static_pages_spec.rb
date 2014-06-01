require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Page One' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do

    before { visit '/about' }

  	let(:heading)    { 'About' }
    let(:page_title) { 'About' }
	end

	describe "Contact page" do

    before { visit '/contact' }

    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "P1"
    expect(page).to have_title(full_title(''))
  end

end
