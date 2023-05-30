module Api
    module V1
        class SleepsController < ApplicationController
            before_action :set_sleep, only: :destroy
            before_action :set_day, only: :create
            before_action :authenticate_user!
            rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

            def create
                @day = Day.create(date: Time.now.beginning_of_day, user: current_user) unless @day
                @sleep = Sleep.new(sleep_params.merge(day: @day))

                if @sleep.save
                    render json: @sleep, status: :created, location: api_v1_sleep_path(@sleep)
                else
                    render json: @sleep.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @sleep.destroy if @sleep
            end
            
            private
            # Use callbacks to share common setup or constraints between actions.
            def set_sleep
                @sleep = Sleep.find(params[:id])
            end

            def sleep_params
                params.require(:sleep).permit(:length)
            end
        end
    end
end