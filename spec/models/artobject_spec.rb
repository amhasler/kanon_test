require 'spec_helper'

describe Artobject do

  let(:user) { FactoryGirl.create(:user) }
  before { @artobject = user.artobjects.build(name: "The Republic") }

  subject { @artobject }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @artobject.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @artobject.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @artobject.name = "a" * 41 }
    it { should_not be_valid }
  end
end