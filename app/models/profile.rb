class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  # バリデーションの追加（必要に応じて）
  validates :bio, length: { maximum: 500 }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'は有効なURLを入力してください' }, allow_blank: true

  # アバター画像のアップロード機能（後述）
  has_one_attached :avatar
end
