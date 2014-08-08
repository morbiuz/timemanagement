require 'rails_helper'

RSpec.describe User, :type => :model do
  it "creates a user correctly" do
    mario = User.create!(name: "Mario", email: "mario@gmail.com", password: "holaquetal", password_confirmation: "holaquetal")

    expect(User.find_by_name("Mario")).to eq(mario)
  end
end
