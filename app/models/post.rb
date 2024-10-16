# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent_post, class_name: 'Post', optional: true
  # ファイルアップロード機能（後述）
  has_one_attached :file

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :child_posts, class_name: 'Post', foreign_key: 'parent_post_id', dependent: :nullify
  # タグ機能（後述）
  acts_as_taggable_on :tags

  validates :title, presence: true
end
