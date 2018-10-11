class CommentsController < ApplicationController
    
    before_action :authenticate_user! 
    
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params.require(:comment).permit(:content))
        @comment.user_id = current_user.id
        
        if @comment.save
            redirect_to post_path(@post)
        else 
            render 'new'
        end
    end
    
    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.update(params.require(:comment).permit(:content))
            redirect_to post_path(@post)
        else
            render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end
    
end
