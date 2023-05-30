module Api
  module V1
    class DaysController < ApplicationController
      before_action :set_day, only: %i[ show update destroy ]
      before_action :authenticate_user!, except: :ret
      rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

      # GET /days
      def index
        @days = Day.all.where(user_id: current_user.id).order(id: :desc)

        render json: @days
      end

      # GET /days/1
      def show
        render json: { day: @day, activities: @day.activities, sleep: @day.sleep, hydration: @day.hydration } 
      end

      # POST /days
      def create
        @day = Day.new(date: Time.now.beginning_of_day, user: current_user)

        if @day.save
          render json: @day, status: :created, location: api_v1_day_url(@day)
        else
          render json: @day.errors, status: :unprocessable_entity
        end
      end

      # DELETE /days/1
      def destroy
        @day.destroy if @day
      end

      def ret
        binding.irb
        head :ok
      end
      
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_day
        @day = Day.find(params[:id])
        render json: { error: 'Unauthorized' }, status: :unauthorized unless @day.user_id == current_user.id
      end

      def jwt_not_found
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end