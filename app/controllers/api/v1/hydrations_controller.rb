module Api
    module V1
        class HydrationsController < ApplicationController
            before_action :set_hydration, only: :destroy
            before_action :set_day, only: :create

            def create
                @day = Day.create(date: Time.now.beginning_of_day) unless @day

                @hydration = @day.build_hydration(hydration_params)
                
                if @hydration.save
                    render json: @hydration, status: :created, location: api_v1_hydration_url(@hydration)
                else
                    render json: @hydration.errors, status: :unprocessable_entity
                end
            end

            def update
                if @hydration.update(hydration_params)
                  render json: hydration, status: :ok
                else
                  render json: { errors: hydration.errors.full_messages }, status: :unprocessable_entity
                end
              end

            def destroy
                @hydration.destroy
            end
            
            private
            # Use callbacks to share common setup or constraints between actions.
            def set_hydration
                @hydration = Hydration.find(params[:id])
            end

            def hydration_params
                params.require(:hydration).permit(:cups)
            end
        end
    end
end