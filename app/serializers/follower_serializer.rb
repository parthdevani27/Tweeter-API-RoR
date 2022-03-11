class FollowerSerializer < ActiveModel::Serializer
  attributes :id, :email,:followers
  def followers
    object.following.map do |item|
      {
        id: item.id,
        user_id: item.user.id,
        user_email: item.user.email,
        tweets:item.user.tweets 
      }
    end
  end
  class TweetSerializer < ActiveModel::Serializer
    attributes :id, :content
  end
end
