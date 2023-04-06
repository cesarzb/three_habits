module Api
    module V1
        class ActivitiesController < ApplicationController
            before_action :set_activity, only: :destroy
            before_action :set_day, only: :create
            rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

            def create
                @day = Day.create(date: Time.now.beginning_of_day) unless @day
                @activity = Activity.new(day: @day, date: Time.now)
                
                if @activity.save
                    render json: @activity, status: :created, location: api_v1_activity_url(@activity)
                else
                    render json: @activity.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @activity.destroy if @activity
            end
            
            private
            # Use callbacks to share common setup or constraints between actions.
            def set_activity
                @activity = Activity.find(params[:id])
            end
        end
    end
end