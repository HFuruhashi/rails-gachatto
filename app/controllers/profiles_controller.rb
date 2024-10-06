class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    # プロフィール表示用のアクション
  end

  def edit
    # プロフィール編集フォーム表示用のアクション
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_profile
    @profile = @user.profile || @user.create_profile!
  end

  def profile_params
    params.require(:profile).permit(:bio, :website, :avatar)
  end

  def correct_user
    redirect_to root_path, alert: 'アクセス権がありません。' unless @user == current_user
  end
end
