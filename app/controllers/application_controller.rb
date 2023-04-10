class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    def set_day
        @day = Day.find_by(date: Time.now.beginning_of_day)
    end

    def not_found_error
        render status: :not_found
    end
end
