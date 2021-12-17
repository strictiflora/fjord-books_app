# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :following_users, class_name:  'Follow',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy

  has_many :followed_by_users, class_name:  'Follow',
                                  foreign_key: 'followed_id',
                                  dependent:   :destroy
  has_many :followings, through: :following_users, source: :followed
  has_many :followers, through: :followed_by_users

  # ユーザーをフォローする
  def follow(other_user)
    following_users.create(followed_id: other_user.id)
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    following_users.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    followings.include?(other_user)
  end
end
