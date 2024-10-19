class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications
    # 未読の通知を既読にする
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
