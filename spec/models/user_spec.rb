require 'rails_helper'


RSpec.describe User, :type => :model do
  it "should have a valid factory" do
  	expect(FactoryGirl.build(:user)).to be_valid
  end

  it "should require a username" do
  	expect(FactoryGirl.build(:user, :name => "")).not_to be_valid
  end
end
