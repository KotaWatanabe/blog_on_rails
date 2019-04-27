class CommentsController < ApplicationController
  before_action :authenticate_user!

    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new comment_params
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            redirect_to post_path(@post)
          else
            @posts = @post.comments.order(created_at: :desc)
            render 'posts/show'
          end

    end

    def destroy
        @comment = Comment.find(params[:id])
        if can?(:crud, @comment)
          @comment.destroy
        redirect_to post_path(@comment.post)
        else
        # head will send an empty HTTP response with a particular reponse code
        # in this case :unauthorized code is 401
        # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
          head:unauthorized
        end
    end


    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end


end
