class TweetSerializer < ActiveModel::Serializer
  attributes :id, :content ,:user
end
