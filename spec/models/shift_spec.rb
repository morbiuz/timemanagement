require 'rails_helper'


RSpec.describe Shift, :type => :model do
	it "should have a valid factory" do
		expect(FactoryGirl.build(:shift)).to be_valid
	end
	it "should validate start date presence" do
		expect(FactoryGirl.build(:shift, :start_date => nil)).not_to be_valid
	end
	it "should validate end date presence" do
		expect(FactoryGirl.build(:shift, :end_date => nil)).not_to be_valid
	end
	it "should check that end_date is always after start_date" do
		expect(FactoryGirl.build(:shift,:start_date => Time.now, :end_date => Time.now - 10.minutes)).not_to be_valid
	end
	it "should return a valid string with start and end dates" do
		time = Time.now
		@shift = FactoryGirl.create(:shift, :start_date => time - 6.minutes, :end_date => time)
		expect(@shift.to_s).to eq("From #{(time.utc-6.minutes).to_s(:long)} to #{time.utc.to_s(:long)} (0.1 hours)")
	end

end
