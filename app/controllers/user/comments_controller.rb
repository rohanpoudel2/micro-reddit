class User::CommentsController < UserController
  before_action :set_post, only: %i[create]
  before_action :set_comment, except: %i[create]

  def create
    if params[:comment][:parent_id].present?
      parent_comment = Comment.find(params[:comment][:parent_id])
      @comment = parent_comment.replies.build(comment_params)
      @comment.post = parent_comment.post
    else
      @comment = @post.comments.build(comment_params)
    end
    @comment.user = current_user
    if @comment.save
      redirect_to user_root_path, notice: 'Commented!!'
    else
      redirect_to user_root_path, alert: @comment.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_root_path, notice: 'Comment Updated!!'
    else
      redirect_to user_root_path, notice: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @comment.destroy
      redirect_to user_root_path, notice: 'Comment Deleted Successfully'
    else
      redirect_to user_root_path, notice: 'Something went wrong'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
