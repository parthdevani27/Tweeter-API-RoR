class TweetsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tweet ,only: [:destroy,:update]

    def index
        @data = current_user.tweets.all
        render :json => {status: 200,type: 'Success',:data => @data}
    end

    def create
        if current_user.tweets.create(tweet_params)
            render :json => {status: 200,type: 'Success',:message => "Your tweet has been uploaded"}
        end
    end

    def destroy
        @tweet.destroy
        render :json => {status: 200,type: 'Success',:message => "Your tweet has been deleted"}
    end

    def update 
        if @tweet.update(tweet_params)
            render :json => {status: 200,type: 'Success',:message => "Your tweet has been updated"}
        else
            render :json => {:type => "error",:message => ""}
        end
    end

    private

    def set_tweet
      @tweet = current_user.tweets.find(params[:id])
    end
    def tweet_params
        params.permit(:content)
    end
end
