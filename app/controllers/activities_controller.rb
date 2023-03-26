class ActivitiesController < ApplicationController
    before_action :set_activity, only: :destroy

    def create
        day = Day.find_by(date: Time.now.beginning_of_day..Time.now.tomorrow.beginning_of_day)
        if !day
            day = Day.create(date: Time.now.beginning_of_day)
        end
        @activity = Activity.new(day: day, date: Time.now)
        
        if @activity.save
            render json: @day, status: :created, location: @day
        else
            render json: @day.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @activity.destroy
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
        @activity = Activity.find(params[:id])
    end
end