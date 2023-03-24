class DaysController < ApplicationController
  before_action :set_day, only: %i[ show update destroy ]

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
    @day = Day.new(date: Time.now)

    if @day.save
      render json: @day, status: :created, location: @day
    else
      render json: @day.errors, status: :unprocessable_entity
    end
  end

  # DELETE /days/1
  def destroy
    @day.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = Day.find(params[:id])
    end
end
