class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize, only: [:edit, :update, :destroy]
    
    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show
        @comment= Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end
    def create
        @post = Post.new post_params
        @post.user = current_user
        if @post.save
            redirect_to root_path
        else
            render :new
        end
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    def edit
    #   if !can? :crud, @question
    #     redirect_to root_path, alert: 'Not authorized'
    #   end
    end

    def update
        if @post.update post_params
            redirect_to post_path(@post.id)
        else
            render :edit
        end
    end

    private
  
    def post_params
      params.require(:post).permit(:title, :body)
    end
  
    def find_post
      @post = Post.find(params[:id])
    end

    def authorize
        unless can?(:crud, @post) 
        redirect_to root_path, alert: 'Not Authorized'
        end
    end
end
