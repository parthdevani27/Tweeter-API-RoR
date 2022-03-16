class Users::SessionsController < Devise::SessionsController
    respond_to :json
    private
    def respond_with(resource, _opts = {})
      if current_user
        render json: { type: 'success',message: 'Login success.',user:current_user }, status: :ok
      else
        render json: {type: 'failer',message: 'Login failed.'}, status: :unauthorized 
      end
    end
    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
    end
    def log_out_success
      render json: {type: 'success',message: "Logged out." }, status: :ok
    end
    def log_out_failure
      render json: { type: 'failer',message: "Logged out failure."}, status: :unauthorized
    end
end