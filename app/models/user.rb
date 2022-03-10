class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  has_many :accounts ,dependent: :destroy
  has_many :tweets
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  
    def following?(other_user_id)
      self.accounts.exists?(following: other_user_id)
    end

    def follow(other_user_id)
      self.accounts.create(following: other_user_id)
    end

    def unfollow(other_user_id)
      self.accounts.find_by(following:other_user_id).destroy
    end
end
