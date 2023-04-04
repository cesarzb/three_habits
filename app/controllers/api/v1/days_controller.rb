module Api
  module V1
    class DaysController < ApplicationController
      before_action :set_day, only: %i[ show update destroy ]
      rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

      # GET /days
      def index
        @days = Day.all

        render json: @days
      end

      # GET /days/1
      def show
        render json: @day
      end

      # POST /days
      def create
        @day = Day.new(date: Time.now.beginning_of_day)

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
      
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_day
        @day = Day.find(params[:id])
      end

      def not_found_error
        render status: :unprocessable_entity
      end
    end
  end
end