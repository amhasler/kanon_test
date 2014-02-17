require 'spec_helper'

describe "ArtobjectPages" do

	subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:artobject, user: user, name: "Iliad", minyear: 1170) }
    let!(:m2) { FactoryGirl.create(:artobject, user: user, name: "Odyssey", minyear: 1170) }
    let!(:m3) { FactoryGirl.create(:artobject, user: user, name: "Symposium", minyear: -300) }
    let!(:m4) { FactoryGirl.create(:artobject, user: user, name: "The Republic", minyear: -300, maxyear: -250) }

    before { visit artobjects_path }

    it { should have_title('Art objects') }
    it { should have_content('Art objects') }

    describe "artobjects" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
      it {should have_content("#{m3.minyear.abs} BCE")}
      it {should have_content("Between #{m4.minyear.abs} BCE and #{m4.maxyear.abs} BCE")}
    end

    describe "when not logged in"

      it "should not have artobject form" do
        #describe absence of artobject form
      end

      it { should_not have_link('edit', href: artobjects_path(id:Artobject.first)) }

    describe "when logged in" do

      before { sign_in user }
      before { visit artobjects_path }

      

      describe "art object creation" do
  	    before { visit artobjects_path }

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

          before do
            fill_in "artobject_name", with: name
            fill_in "artobject_minyear", with: minyear
            fixture_file_upload(Rails.root + 'spec/fixtures/images/test_image.jpg', 'image/png')     
            click_button "Go"
          end

          it { should have_selector('div.alert.alert-success') }
          it { should have_content(name) }
          it { should have_content(minyear) }
          it { should have_xpath("//img")}
  	    end
  	  end

      describe "edit links" do

        it { should_not have_link('edit', href: artobjects_path(id:Artobject.first)) }

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
