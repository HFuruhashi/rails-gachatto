class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
	  @post = Post.find(params[:post_id])
	  @comment = @post.comments.build(comment_params)
	  @comment.user = current_user
	  if @comment.save
		redirect_to post_path(@post), notice: 'コメントが投稿されました。'
	  else
		redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
	  end
	end

	def destroy
	  @comment = Comment.find(params[:id])
	  if @comment.user == current_user
		@comment.destroy
		redirect_to post_path(@comment.post), notice: 'コメントが削除されました。'
	  else
		redirect_to post_path(@comment.post), alert: 'コメントを削除する権限がありません。'
	  end
	end

	private

	def comment_params
	  params.require(:comment).permit(:content)
	end
  end
