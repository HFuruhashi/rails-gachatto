class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :action, presence: true
end
