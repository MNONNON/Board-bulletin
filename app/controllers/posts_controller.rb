class PostsController < ApplicationController

    before_action :authenticate_user! ,except: [:index, :show]

    def index
        @posts = Post.all.order("created_at DESC")
    end
    
    def new
        @post = current_user.posts.build()
    end
    
    def create
        @post = current_user.posts.build(params.require(:post).permit(:title,:description))
        if @post.save
            redirect_to posts_path
        else
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
        if @post.update(params.require(:post).permit(:title, :description))
            redirect_to post_path
        else 
            render 'form'
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to root_path
    end
    
end

