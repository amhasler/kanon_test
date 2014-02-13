require 'spec_helper'

describe "ArtobjectPages" do

	subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:artobject, user: user, name: "Iliad") }
    let!(:m2) { FactoryGirl.create(:artobject, user: user, name: "Odyssey") }

    before { sign_in user }
    before { visit artobjects_path }

    it { should have_title('Art objects') }
    it { should have_content('Art objects') }

    describe "artobjects" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
    end

    describe "art object creation" do
	    before { visit artobjects_path }

	    describe "with invalid information" do

	      it "should not create an artobject" do
	        expect { click_button "Create" }.not_to change(Artobject, :count)
	      end

	      describe "error messages" do
	        before { click_button "Create" }
	        it { should have_content('error') }
	      end
	    end

	    describe "with valid information" do

	      before { fill_in 'artobject_name', with: "Lorem ipsum" }
	      it "should create an artobject" do
	        expect { click_button "Create" }.to change(Artobject, :count).by(1)
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
