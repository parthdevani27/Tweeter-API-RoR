class FollowingSerializer < ActiveModel::Serializer
  attributes :id, :email, :following
  # has_many :tweets,serializer: TweetSerializer
  def following
    object.accounts.map do |account|
      {
        id: account.id,
        user_id: account.following,
        user_email: User.find(account.following).email,
      }
    end
  end


end
