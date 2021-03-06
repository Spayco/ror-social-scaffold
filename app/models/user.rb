class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  def mutual?(current_user, user)
    number = 0
    user.friendships.where(confirmed: true).each do |v|
      number += 1 if current_user.isfriend?(v.friend_id)
    end
    number
  end

  def isfriend?(id)
    Friendship.where(user_id: self.id, friend_id: id, confirmed: true).exists?
  end
end
