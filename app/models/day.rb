class Day < ApplicationRecord
    belongs_to :user
    has_many :activities, dependent: :destroy
    has_one :sleep, dependent: :destroy
    has_one :hydration, dependent: :destroy

    validates :date, uniqueness: {scope: :user_id, 
                                    message: "User can only have one day with a specific date"}
end
