class Sleep < ApplicationRecord
    belongs_to :day
    belongs_to :user
    
    validates :day, uniqueness: true
end
