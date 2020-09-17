class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comment.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: post_path(@post.id))
    else
      flash[:danger] = "コメントできませんでした"
      redirect_back(fallback_location: post_path(@post.id))
    end 
  end 

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: post_path(@post.id))
  end 

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end