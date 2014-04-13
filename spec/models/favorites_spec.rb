require 'spec_helper'

describe Favorite do

  let(:user) { FactoryGirl.create(:user) }
  let(:favorite_artobjects) { FactoryGirl.create(:artobject) }
  let(:favorite) { user.favorites.build(id: favorite_artobjects.id) }

  subject { favorite }

  it { should be_valid }
end