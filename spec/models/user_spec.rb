require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) { attributes_for(:user) }

  it "works for valid parameters" do
    user = User.create(user_params)
    expect(user).to be_valid
  end

  context "email" do
    it "can't by blank" do
      user = User.create(user_params.merge(email: ""))
      expect(user).not_to be_valid
    end

    it "can't be shorter than 5 characters" do
      user = User.create(user_params.merge(email: "aaaa"))
      expect(user).not_to be_valid
    end

    it "can't be longer than 55 characters" do
      user = User.create(user_params.merge(email: "a" * 44 + "@example.com"))
      expect(user).not_to be_valid
    end

    it "has to be of valid format" do
      user = User.create(user_params.merge(email: "aaaa@aaaa"))
      second_user = User.create(user_params.merge(email: "aaaaaaaa"))
      expect(user).not_to be_valid
    end
  end

  context "password" do
    it "can't by blank" do
      user = User.create(user_params.merge(password: "", password_confirmation: ""))
      expect(user).not_to be_valid
    end

    it "can't be shorter than 8 characters" do
      user = User.create(user_params.merge(password: "a" * 7, password_confirmation: "a" * 7))
      expect(user).not_to be_valid
    end

    it "can't be longer than 55 characters" do
      user = User.create(user_params.merge(password: "a" * 56, password_confirmation: "a" * 56))
      expect(user).not_to be_valid
    end

    it "can't be different than password confirmation" do
      user = User.create(user_params.merge(password: "Password1@", password_confirmation: "Password2@"))
      expect(user).not_to be_valid
    end
  end
end
