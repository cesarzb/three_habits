class Sleep < ApplicationRecord
    belongs_to :day
    has_one :user, through: :day
    
    validates :day, uniqueness: true
end