class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
  
      register_failed(resource)
    end
  
    def register_success
      render json: { message: 'Signed up sucessfully.' }, status: :ok
    end
  
    def register_failed(resource)
      render json: resource.errors.to_json , status: :unprocessable_entity
    end
end