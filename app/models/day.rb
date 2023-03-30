class Day < ApplicationRecord
    has_many :activities, dependent: :destroy
    has_one :sleep, dependent: :destroy
    has_one :hydration, dependent: :destroy

    validates :date, uniqueness: :true
end
