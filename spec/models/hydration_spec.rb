require 'rails_helper'

RSpec.describe Hydration, type: :model do
  let(:user) { create(:user) }
  let(:day) { create(:day, user: user) }

  it "is valid for valid attributes" do
    expect(Hydration.new(day: day, cups: 10, user: user)).to be_valid
  end

  context "is invalid when day attribute" do
    it "is missing" do
      expect(Hydration.new(day: nil, cups: 10, user: user)).not_to be_valid
    end

    context "isn't unique"
      it "for the same user" do
        first_hydration = Hydration.create(day: day, cups: 12, user: user)
        second_hydration = Hydration.new(day: day, cups: 5, user: user)
        expect(first_hydration).to be_valid
        expect(second_hydration).not_to be_valid
      end
  end

  context "is invalid when cups attribute" do
    it "isn't numerical" do
      expect(Hydration.new(day: day, cups: "text", user: user)).not_to be_valid
    end

    it "is less than 0" do
      expect(Hydration.new(day: day, cups: -1, user: user)).not_to be_valid
    end
  end

  context "is invalid when user attribute" do
    it "is missing" do
      expect(Hydration.new(day: day, cups: 10, user: nil)).not_to be_valid
    end
  end
end
