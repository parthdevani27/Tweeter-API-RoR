class TweetsController < ApplicationController
    before_action :authenticate_user!

    def index
        @data = current_user.tweets.all
        render json: {
            data: ActiveModelSerializers::SerializableResource.new(@data, each_serializer: TweetSerializer),
            message: ['Tweets list fetched successfully'],
            status: 200,type: 'Success'
        }
    end

    def create
        if current_user.tweets.create(tweet_params)
            render :json => {status: 200,type: 'Success',:message => "Your tweet has been uploaded"}
        else
            render :json => {type: 'failer',:message => "An error occurred"}
        end
    end

    def destroy
        if current_user.tweets.exists?(params[:id])

            @tweet = current_user.tweets.find(params[:id])

            if @tweet.destroy
                render :json => {status: 200,type: 'Success',:message => "Your tweet has been deleted"}
            else
                render :json => {type: 'failer',:message => "An error occurred"}
            end
        else
            render :json => {type: 'failer',:message => "Tweet not exists"}
        end
    end

    def update 
        if current_user.tweets.exists?(params[:id])

            @tweet = current_user.tweets.find(params[:id])

            if @tweet.update(tweet_params)
                render :json => {status: 200,type: 'Success',:message => "Your tweet has been updated"}
            else
                render :json => {type: 'failer',:message => "An error occurred"}
            end
        else
            render :json => {type: 'failer',:message => "Tweet not exists"}
        end
    end

    private


    def tweet_params
        params.permit(:content)
    end
end
