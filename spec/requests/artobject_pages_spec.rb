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

    it { should have_title('Art objects') }
    it { should have_content('Art objects') }

    describe "artobjects" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
      it { should have_content("#{m3.minyear.abs} BCE") }
      it { should have_content("Between #{m4.minyear.abs} BCE and #{m4.maxyear.abs} BCE") }

      describe "filtered" do
        before do
          fill_in "tags", with: "Plato, Rhetoric"
          click_button "Filter"
        end

        it { should have_css(".art_object", count: 1) }
      end

      describe "sorted" do
        before { click_link "Sort Ascending" }

        it { should have_selector("ol li:nth-child(1)", text: "#{m1.minyear.abs} BCE") }
        it { should have_selector("ol li:nth-child(2)", text: "#{m2.minyear.abs} BCE") }
      end
    end

    describe "when not logged in" do

      it { should_not have_css("#new_artobject")}

      it { should_not have_link('edit', href: artobjects_path(id:Artobject.first)) }

    end

    describe "when logged in" do

      before { sign_in user }
      before { visit artobjects_path }

      

      describe "art object creation" do

  	    describe "with invalid information" do

  	      it "should not create an artobject" do
  	        expect { click_button "Go" }.not_to change(Artobject, :count)
  	      end

  	      describe "error messages" do
  	        before { click_button "Go" }
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
            fixture_file_upload(Rails.root + 'spec/fixtures/images/test_image.jpg', 'image/png')     
            click_button "Go"
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

          describe "edit links as art object owner"
            describe "should be able to edit art object" do
            
            before do
              click_link('edit', match: :first)
              fill_in "artobject_name", with: "BOOM"
              click_button "Go"
            end

            it { should have_content("BOOM") }
          end
  	    end
  	  end

      describe "edit links" do

        describe "as an admin user" do
          let(:new_name) { "Elektra" }
          let(:admin) { FactoryGirl.create(:admin) }

          before do
            sign_in admin
            visit artobjects_path
          end

          it { should have_link('edit', href: artobjects_path(id:Artobject.first)) }

          describe "should be able to edit art object" do
            
            before do
              click_link('edit', match: :first)
              fill_in "artobject_name", with: new_name
              click_button "Go"
            end

            it { should have_content(new_name) }
          end

        end

      end

  	  describe "delete links" do

        it { should_not have_link('delete') }

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }

          before do
            sign_in admin
            visit artobjects_path
          end

          it { should have_link('delete', href: artobject_path(Artobject.first)) }
          
          it "should be able to delete art object" do
            expect do
              click_link('delete', match: :first)
            end.to change(Artobject, :count).by(-1)
          end
        end

      end
    end

  end

end
