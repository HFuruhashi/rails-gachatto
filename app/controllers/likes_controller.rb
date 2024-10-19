class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post

	def create
	  @like = @post.likes.build(user: current_user)
	  if @like.save
		# 通知の作成
		@post.create_notification_like!(current_user)
		respond_to do |format|
		  format.html { redirect_to post_path(@post), notice: '「いいね！」しました。' }
		  format.js
		end
	  else
		respond_to do |format|
		  format.html { redirect_to post_path(@post), alert: '「いいね！」できませんでした。' }
		  format.js
		end
	  end
	end

	def destroy
	  @like = @post.likes.find_by(user: current_user)
	  if @like
		@like.destroy
		respond_to do |format|
		  format.html { redirect_to post_path(@post), notice: '「いいね！」を取り消しました。' }
		  format.js
		end
	  else
		respond_to do |format|
		  format.html { redirect_to post_path(@post), alert: '「いいね！」が見つかりません。' }
		  format.js
		end
	  end
	end

	private

	def set_post
	  @post = Post.find(params[:post_id])
	end
  end
