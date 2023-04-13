class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: self
  # include Users::Allowlist

  # devise :database_authenticatable, 
  #   :confirmable,
  #   :registrable,
  #   :recoverable,
  #   :rememberable,
  #   :validatable,
  #   :jwt_authenticatable, 
  #   jwt_revocation_strategy: self

  def self.find_by_jwt(payload)
    find(payload['sub'])
  end
end
