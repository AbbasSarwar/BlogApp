class LikesController < ApplicationController
    def create
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
      @like = Like.new(user: @user, post: @post)
      if @like.save
        @post.update_column(:likes_counter, @post.likes.count)
        redirect_to user_post_path(@user, @post)
      else
        # Handle error if like couldn't be saved
      end
    end
  
    private
  
    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
  end
  