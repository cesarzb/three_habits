require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe "uniqueness validation" do
    it "allows to create a day with a unique date" do
      day = Day.new(date: Time.now.beginning_of_day, user: user)

      expect(day).to be_valid
    end

    it "doesn't allow to create a day with non unique date" do
      Day.create(date: Time.now.beginning_of_day, user: user)
      day = Day.new(date: Time.now.beginning_of_day, user: user)
      
      expect(day).not_to be_valid
    end

    it "allows to create a day with non unique date for different users" do
      Day.create(date: Time.now.beginning_of_day, user: user)
      day = Day.new(date: Time.now.beginning_of_day, user: other_user)
      
      expect(day).to be_valid
    end
  end
end
