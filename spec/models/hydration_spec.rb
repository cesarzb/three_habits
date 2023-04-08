require 'rails_helper'

RSpec.describe Hydration, type: :model do
  let(:day) { create(:day) }

  it "is valid for valid attributes" do
    expect(Hydration.new(day: day, cups: 10)).to be_valid
  end

  context "is invalid when day attribute" do
    it "is missing" do
      expect(Hydration.new(day: nil, cups: 10)).not_to be_valid
    end

    it "isn't unique" do
      first_hydration = Hydration.create(day: day, cups: 12)
      second_hydration = Hydration.new(day: day, cups: 5)
      expect(first_hydration).to be_valid
      expect(second_hydration).not_to be_valid
    end
  end

  context "is invalid when cups attribute" do
    it "isn't numerical" do
      expect(Hydration.new(day: day, cups: "text")).not_to be_valid
    end

    it "is less than 0" do
      expect(Hydration.new(day: day, cups: -1)).not_to be_valid
    end
  end
end
