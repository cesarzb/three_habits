class Sleep < ApplicationRecord
    belongs_to :day
    validates :day, uniqueness: true
end
