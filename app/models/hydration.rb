class Hydration < ApplicationRecord
    belongs_to :day
    validates :cups, numericality: { more_than_or_equal_to: 11,  only_integer: true, allow_nil: true  }
end
