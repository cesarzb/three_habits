class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist
  validates :email, presence: true, length: { minimum: 5, maximum: 55 }, format: /\A\S+@.+\.\S+\z/
  validates :password, presence: true, length: { minimum: 8, maximum: 55 }, confirmation: true
  validates :password_confirmation, presence: true


  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: self


  def self.find_by_jwt(payload)
    find(payload['sub'])
  end
end
