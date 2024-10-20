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

  # バリデーションの追加
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }

  def create_notification_comment!(current_user, comment_id)
    # 自分の投稿に対するコメントの場合は通知を作成しない
    return if user_id == current_user.id

    notification = Notification.new(
      visitor_id: current_user.id,
      visited_id: user_id,
      post_id: id,
      comment_id: comment_id,
      action: 'comment'
    )
    notification.save if notification.valid?
  end

  def create_notification_like!(current_user)
    # 自分の投稿への「いいね！」の場合は通知を作成しない
    return if user_id == current_user.id

    # 既に「いいね！」の通知が存在するか確認
    temp = Notification.where(
      visitor_id: current_user.id,
      visited_id: user_id,
      post_id: id,
      action: 'like'
    )

    if temp.blank?
      notification = Notification.new(
        visitor_id: current_user.id,
        visited_id: user_id,
        post_id: id,
        action: 'like'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_link!(current_user)
    # 自分の投稿に紐づける場合は通知を作成しない
    return if parent_post.user_id == current_user.id

    notification = Notification.new(
      visitor_id: current_user.id,
      visited_id: parent_post.user_id,
      post_id: parent_post.id,
      action: 'link'
    )
    notification.save if notification.valid?
  end
end
