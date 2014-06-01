require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:u1) { FactoryGirl.create(:user, name: "Brandon", email: "papa@email.com", creator_list: "Homer", medium_list: "Lyric") }
    let!(:u2) { FactoryGirl.create(:user, name: "Santa Claus", email: "mama@email.com", creator_list: "Homer", medium_list: "Writing") }
    let!(:u3) { FactoryGirl.create(:user, name: "Tooth Fairy", email: "brother@email.com", creator_list: "Plato", language_list: "Rhetoric, Writing") }
    let!(:u4) { FactoryGirl.create(:user, name: "George Washington", email: "sister@email.com", creator_list: "Plato", society_list: "Classical Athens") }
    before(:each) do
      log_in user
      visit users_path
    end

    it { should have_title('Contributors') }
    it { should have_content('Contributors') }
    it { should have_content(u1.name) }
    it { should have_content(u2.name) }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "filtered" do
      before do
        fill_in "tags", with: "Plato, Rhetoric"
        click_button "Submit"
      end

      it { should_not have_content "Brandon" }
      it { should_not have_content "Sant Claus" }
      it { should have_content "Tooth Fairy" }
      it { should_not have_content "George Washington" }
    end


    describe "delete links" do

      it { should_not have_link('Delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          log_in admin
          visit users_path
        end

        it { should have_link('Delete', href: user_path(User.first)) }
        
        it "should be able to delete another user" do
          expect do
            click_link('Delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('Delete', href: user_path(admin)) }
      end
    end

  end

  describe "profile page" do
    let!(:user) { FactoryGirl.create(:user, name: "Tooth Fairy", email: "brother@email.com", creator_list: "Plato", language_list: "Rhetoric, Writing") }

    before { visit user_path(user) }

    it { should have_content("Tooth Fairy") }
    it { should have_title("Tooth Fairy") }
    it { should have_content("Plato") }
    it { should have_content("Rhetoric") }
    it { should have_content("Writing") }
    it { should have_content("Writing") }
    it { should have_link("this contributor's favorite works", href: artobjects_user_path(user)) }
    it { should_not have_link('Edit Profile', href: artobjects_user_path(user)) }

    describe "when logged in as user" do

      before { log_in user }
      before { visit user_path(user) }

      it { should have_link('Edit Profile', href: edit_user_path(user)) }

    end

    describe "when logged in as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do 
        log_in admin
        visit user_path(user)
      end

      it { should have_link('Edit Profile', href: edit_user_path(user)) }

    end


  end

  describe "login page" do
    #Logged in user should NOT be able to visit login page
  end

	describe "signup page" do

    #Logged in user should NOT be able to visit signup page

    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit) { "Create my profile" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user[name]",         with: "Example User"
        fill_in "user[email]",     with: "user@example.com"
        fill_in "user[password]",     with: "foobar"
        fill_in "user[password_confirmation]", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Log out') }
        it { should have_title("All works") }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

      end

    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      log_in user
      visit edit_user_path(user)
    end

    describe "with invalid information" do
      before do
        fill_in "user[name]", with: " "
        click_button "Update my profile"
      end
 
      it { should have_content('error') }
    end

    describe "with valid information" do
      before do
        fill_in "user[name]", with: "BOOMBOOMBOOM"
        click_button "Update my profile"
      end

      it { should have_content("BOOMBOOMBOOM") }
    end
  end
end
