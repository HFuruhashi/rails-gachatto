class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    permitted_types = ['Illustration', 'Music']
    if permitted_types.include?(params[:type])
      @post = params[:type].constantize.new
    else
      redirect_to root_path, alert: '不正な投稿タイプです。'
    end
  end

  def create
    permitted_types = ['Illustration', 'Music']
    post_type = params[:post][:type]
    if permitted_types.include?(post_type)
      @post = post_type.constantize.new(post_params)
      @post.user = current_user
      if @post.save
        redirect_to post_path(@post), notice: '投稿が作成されました。'
      else
        render :new
      end
    else
      redirect_to root_path, alert: '不正な投稿タイプです。'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :file, :tag_list)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to posts_path, alert: 'この投稿に対する権限がありません。'
    end
  end
end
