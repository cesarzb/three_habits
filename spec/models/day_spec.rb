require 'rails_helper'

RSpec.describe Day, type: :model do
  describe "uniqueness validation" do
    it "allows to create a day with a unique date" do
      day = Day.new(date: Time.now.beginning_of_day)

      expect(day).to be_valid
    end

    it "doesn't allow to create a day with non unique date" do
      Day.create(date: Time.now.beginning_of_day)
      day = Day.new(date: Time.now.beginning_of_day)
      
      expect(day).not_to be_valid
    end
  end
end
