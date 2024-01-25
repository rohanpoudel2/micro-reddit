class User::CommentsController < User::PostsController
    before_action :set_post

    def create
        if params[:comment][:parent_id].present?
            parent_comment = Comment.find(params[:comment][:parent_id])
            @comment = parent_comment.replies.build(comment_params)
        else
            @comment = @post.comments.build(comment_params)
        end

        @comment.user = current_user

        if @comment.save
            redirect_to user_root_path, notice: "Commented!!"
        else
            redirect_to user_root_path, alert: @comment.errors.full_messages.to_sentence
        end
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end
