class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to root_path
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
      flash[:success] = "投稿を編集しました！"
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "編集に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to root_path
  end

  
  private

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:store, :prefecture, :genre, :ramen, :impression, :image)
  end 

end
