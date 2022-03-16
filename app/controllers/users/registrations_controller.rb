class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    private
    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end
    def register_success
      render json: { status: 200,type: 'success',message: 'Signed up success.' }
    end
    def register_failed
      render json: { type: 'failer',message: "Signed up failure." }
    end
end