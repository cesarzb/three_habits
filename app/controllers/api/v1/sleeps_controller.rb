module Api
    module V1
        class SleepsController < ApplicationController
            before_action :set_sleep, only: :destroy
            before_action :set_day, only: :create

            def create
                @day = Day.create(date: Time.now.beginning_of_day) unless @day
                @sleep = Sleep.new(day: @day, length: params[:length])
                
                if @sleep.save
                    render json: @sleep, status: :created, location: api_v1_sleep_path(@sleep)
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