class Day < ApplicationRecord
    has_many :activities, dependent: :destroy
    has_one :sleep, dependent: :destroy
end
