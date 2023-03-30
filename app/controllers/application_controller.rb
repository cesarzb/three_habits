class ApplicationController < ActionController::API
    def set_day
        @day = Day.find_by(date: Time.now.beginning_of_day)
    end
end
