# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  # ファイルアップロード機能（後述）
  has_one_attached :file
  # タグ機能（後述）
  acts_as_taggable_on :tags

  validates :title, presence: true
end
