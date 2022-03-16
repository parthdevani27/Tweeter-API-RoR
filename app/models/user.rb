class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  has_many :accounts ,dependent: :destroy
  has_many :following, class_name: "Account", foreign_key: "following"
  has_many :tweets ,dependent: :destroy
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  
    def following?(follow_user_id)
      self.accounts.exists?(following: follow_user_id)
    end

    def follow(follow_user_id)
      self.accounts.create(following: follow_user_id)
    end

    def unfollow(follow_user_id)
      self.accounts.find_by(following:follow_user_id).destroy
    end


end
