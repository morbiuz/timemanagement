require 'rails_helper'


RSpec.describe User, :type => :model do
  it "should have a valid factory" do
  	expect(FactoryGirl.build(:user)).to be_valid
  end
  it "should require a username" do
  	expect(FactoryGirl.build(:user, :name => "")).not_to be_valid
  end
  it "should require a provider" do
  	expect(FactoryGirl.build(:user, :provider => "")).not_to be_valid
  end
  it "should require at least 6 chars for password" do
  	expect(FactoryGirl.build(:user, :password => "asdf", :password_confirmation => "asdf")).not_to be_valid
  end
  it "should require a valid email address" do
  	expect(FactoryGirl.build(:user, :email => "bad_email")).not_to be_valid
  end
  it "should require a valid email address" do
  	expect(FactoryGirl.build(:user, :email => "bad_email@bad_host")).not_to be_valid
  end
  it "should require password confirmation" do
  	expect(FactoryGirl.build(:user, :password => "password", :password_confirmation => "")).not_to be_valid
  end
  it "should authenticate correctly a user with email" do
  	user = FactoryGirl.create(:user)
  	expect(User.authenticate("mario@gmail.com","whatever")).to eq(user)
  end
  it "should authenticate correctly a user with name" do
  	user = FactoryGirl.create(:user)
  	expect(User.authenticate("Mario","whatever")).to eq(user)
  end
  it "should not authenticate if a bad password is given" do
  	user = FactoryGirl.create(:user)
  	expect(User.authenticate("Mario","badpassword")).to eq(false)
  end
end
