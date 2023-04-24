class Hydration < ApplicationRecord
    belongs_to :day
    belongs_to :user

    validates :cups, numericality: { greater_than_or_equal_to: 0,  only_integer: true, allow_nil: true }
    validates :day, uniqueness: true
end
