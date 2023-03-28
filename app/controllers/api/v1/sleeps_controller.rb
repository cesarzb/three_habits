module Api
    module V1
        class SleepsController < ApplicationController
            before_action :set_sleep, only: :destroy

            def create
                day = Day.find_by(date: Time.now.beginning_of_day)
                if !day
                    day = Day.create(date: Time.now.beginning_of_day)
                end

                @sleep = Sleep.new(day: day, date: Time.now)
                
                if @sleep.save
                    render json: @sleep, status: :created, location: @sleep
                else
                    render json: @sleep.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @sleep.destroy
            end
            
            private
            # Use callbacks to share common setup or constraints between actions.
            def set_sleep
                @sleep = Sleep.find(params[:id])
            end
        end
    end
end