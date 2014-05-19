require 'spec_helper'

describe "ArtobjectPages" do

	subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:artobject, user: user, name: "Iliad", minyear: -300, creator_list: "Homer", medium_list: "Lyric") }
    let!(:m2) { FactoryGirl.create(:artobject, user: user, name: "Odyssey", minyear: -250, creator_list: "Homer", medium_list: "Writing") }
    let!(:m3) { FactoryGirl.create(:artobject, user: user, name: "Symposium", minyear: -200, creator_list: "Plato", language_list: "Rhetoric, Writing") }
    let!(:m4) { FactoryGirl.create(:artobject, user: user, name: "The Republic", minyear: -150, maxyear: -250, creator_list: "Plato", society_list: "Classical Athens") }
    before { visit artobjects_path }

    it { should have_title('All works') }
    it { should have_content('Discover Works') }

    describe "artobjects" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
      it { should have_content("#{m3.minyear.abs} BCE") }
      it { should have_content("Between #{m4.minyear.abs} BCE and #{m4.maxyear.abs} BCE") }

      describe "filtered" do
        before do
          fill_in "tags", with: "Plato, Rhetoric"
          click_button "Submit"
        end

        it { should_not have_content "Iliad" }
        it { should_not have_content "Odyssey" }
        it { should have_content "Symposium" }
        it { should_not have_content "The Republic" }
      end

      describe "sought" do
        before do
          fill_in "tags", with: "Iliad"
          click_button "Submit"
        end

        it { should have_content "Iliad" }
        it { should_not have_content "Odyssey" }
        it { should_not have_content "Symposium" }
        it { should_not have_content "The Republic" }
      end

      #describe "sorted" do
      #  before { click_link "Sort oldest to newest" }

      #  it { should have_selector("ol li:nth-child(1)", text: "#{m1.minyear.abs} BCE") }
      #  it { should have_selector("ol li:nth-child(2)", text: "#{m2.minyear.abs} BCE") }
      #end
    end

    describe "when not logged in" do

      it { should have_css("#new_artobject") }

      it { should_not have_link('Edit', href: edit_artobject_path(id:Artobject.first)) }

      it { should_not have_css(".make_favorite") }



    end

    describe "when logged in" do

      before { log_in user }
      before { visit artobjects_path }

      it { should have_css("#new_artobject") }

      it { should have_css(".make_favorite") }

      describe "edit links" do

        describe "as an admin user" do
          let(:new_name) { "Elektra" }
          let(:admin) { FactoryGirl.create(:admin) }

          before do
            log_in admin
            visit artobjects_path
          end

          it { should have_link('Edit', href: edit_artobject_path(id:Artobject.first)) }

        end

      end

  	  describe "delete links" do

        it { should_not have_link('Delete') }

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }

          before do
            log_in admin
            visit artobjects_path
          end

          it { should have_link('Delete', href: artobject_path(Artobject.first)) }
          
          it "should be able to delete art object" do
            expect do
              click_link('Delete', match: :first)
            end.to change(Artobject, :count).by(-1)
          end
        end

      end
    end

  end

  describe "new" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      let(:user) { FactoryGirl.create(:user) }

      describe "in the artobjects controller" do

        describe "submitting to the create action" do
          before { post artobjects_path }
          specify { expect(response).to redirect_to(login_path) }
        end

      end

      describe "visiting artobjects#new" do
        before { get new_artobject_path }
        specify { expect(response).to redirect_to(login_path) }
      end

    end

    let(:user) { FactoryGirl.create(:user) }


    before do
      log_in user
      visit new_artobject_path
    end

    describe "art object creation" do

      describe "with invalid information" do

        it "should not create an artobject" do
          expect { click_button "Done" }.not_to change(Artobject, :count)        

        end

        describe "error messages" do
          before { click_button "Done" }
          it { should have_content('error') }
        end

      end

      describe "with valid information" do

        let(:name)  { "Laws" }
        let(:minyear) { 300 }
        let(:creators) { "Plato, Socrates" }
        let(:locations) { "Greece, Athens, Attica" }
        let(:languages) { "Greek, Attic" }
        let(:societies) { "Ancient Greece, Athens" }
        let(:media) { "Rhetoric, Writing" }

        before do
          fill_in "artobject_name", with: name
          fill_in "artobject_minyear", with: minyear
          fill_in "artobject_creator_list", with: creators
          fill_in "artobject_location_list", with: locations
          fill_in "artobject_language_list", with: languages
          fill_in "artobject_society_list", with: societies
          fill_in "artobject_medium_list", with: media
          #fixture_file_upload(Rails.root + 'spec/fixtures/images/test_image.jpg', 'image/png')     
          click_button "Done"
        end

        it { should have_selector('div.alert.alert-success') }
        it { should have_content(name) }
        it { should have_content(minyear) }
        it { should have_link("Plato") }
        it { should have_link("Socrates") }
        it { should have_link("Attica") }
        it { should have_link("Greece")}
        it { should have_link("Greek") }
        it { should have_link("Athens") }
        it { should have_link("Writing") }
        it { should have_xpath("//img")}

      end
    end
  end
=begin
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:artobject, user: user, name: "Iliad", minyear: -300, creator_list: "Homer", medium_list: "Lyric") }
    before do
      log_in user
      visit edit_artobject_path(m1)
    end

    describe "art object owner should be able to edit art object"
      
      before do
        click_link('Edit', match: :first)
        fill_in "artobject_name", with: "BOOM"
        click_button "Done"
      end

      it { should have_content("BOOM") }
    end
  end
=end
end
