class FollowingSerializer < ActiveModel::Serializer
  attributes :id, :email, :following
  # has_many :tweets,serializer: TweetSerializer
  def following
    object.accounts.map do |account|
      {
        id: account.id,
        user: User.find(account.following),
      }
    end
  end


end
