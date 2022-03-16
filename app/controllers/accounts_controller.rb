class AccountsController < ApplicationController
before_action :authenticate_user!

    def create
        @follow_user_id = params[:user_id]
        if User.exists?(@follow_user_id) && @follow_user_id != current_user.id
            if current_user.following?(@follow_user_id)
                render :json => {:type => "error",:message => "You are already following this user"}
            else
                current_user.follow(@follow_user_id)
                render :json => {status: 200,type: 'Success',:message => "You are now following this user"}
            end
        else
            render :json => {:type => "error",:message => "Invalid User Id"}
        end

    end

    def destroy
        @follow_user_id = params[:id]
        if User.exists?(@follow_user_id)
            if current_user.following?(@follow_user_id)
                current_user.unfollow(@follow_user_id)
                render :json => {status: 200,type: 'Success',:message => "You are unfollowed this user"}
            else
                render :json => {:type => "error",:message => "You are not following this user"}
            end
        else
            render :json => {:type => "error",:message => "Invalid User Id"}
        end
    end

    def followers
        render json: current_user, serializer: FollowerSerializer

        # render json: {
        #     data: ActiveModelSerializers::SerializableResource.new(current_user, serializer: FollowerSerializer),
        #     message: ['followers list fetched successfully'],
        #     status: 200,type: 'Success'
        # }
    end

    def following
        render json: {
            data: ActiveModelSerializers::SerializableResource.new(current_user, serializer: FollowingSerializer),
            message: ['following list fetched successfully'],
            status: 200,
            type: 'Success'
        }
    end

    private

    def user_params
        params.permit(:user_id)
    end

end
