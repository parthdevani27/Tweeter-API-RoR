class FollowerSerializer < ActiveModel::Serializer
  attributes :id, :email,:followers
  def followers
    object.following.map do |item|
      {
        id: item.id,
        user: item.user,
        tweets: ActiveModelSerializers::SerializableResource.new(item.user.tweets , each_serializer: TweetSerializer)
      }
    end
  end
end
