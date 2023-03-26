class Day < ApplicationRecord
    has_many :activities, dependent: :destroy
end
