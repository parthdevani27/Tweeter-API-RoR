class AccountsController < ApplicationController
before_action :authenticate_user!

    def create
        @other_user_id = params[:user_id]
        if User.exists?(@other_user_id) && @other_user_id != current_user.id
            if current_user.following?(@other_user_id)
                render :json => {:type => "error",:message => "You are already following this user"}
            else
                current_user.follow(@other_user_id)
                render :json => {status: 200,type: 'Success',:message => "You are now following this user"}
            end
        else
            render :json => {:type => "error",:message => "Invalid User Id"}
        end

    end

    def destroy
        @other_user_id = params[:id]
        if User.exists?(@other_user_id)
            if current_user.following?(@other_user_id)
                current_user.unfollow(@other_user_id)
                render :json => {status: 200,type: 'Success',:message => "You are unfollowed this user"}
            else
                render :json => {:type => "error",:message => "You are not following this user"}
            end
        else
            render :json => {:type => "error",:message => "Invalid User Id"}
        end
    end

    def followers
        render json: {
            data: ActiveModelSerializers::SerializableResource.new(current_user, serializer: FollowerSerializer),
            message: ['followers list fetched successfully'],
            status: 200,type: 'Success'
        }
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
