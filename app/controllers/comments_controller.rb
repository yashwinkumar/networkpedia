class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.comments.new params[:comment]
   if @post.save
    flash.notice = "Comment created."
    redirect_to @post
   else
     flash.alert = "Cannot create comment"
     redirect_to @post
   end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if user_signed_in?
    @comment.destroy
    flash[:notice] = "Comment deleted"
    redirect_to @comment.post
    else
      flash[:notice] = "Login to delete the post"
      redirect_to @comment.post
    end
   end
end
