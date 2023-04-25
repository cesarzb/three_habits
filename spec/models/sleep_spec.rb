require 'rails_helper'

RSpec.describe Sleep, type: :model do
  let(:user) { create(:user) }
  let(:day) { create(:day, user: user) }
  
  it "is valid for valid attributes" do
    expect(Sleep.new(day: day, length: "08:15")).to be_valid
  end

  context "is invalid when day attribtue" do
    it "is missing" do
      expect(Sleep.new(day: nil, length: "08:15")).not_to be_valid
    end

    it "isn't unique" do
      first_sleep = Sleep.create(day: day, length: "08:15")
      second_sleep = Sleep.new(day: day, length: "09:04") 

      expect(first_sleep).to be_valid
      expect(second_sleep).not_to be_valid
    end
  end
end
