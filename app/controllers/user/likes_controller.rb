class User::LikesController < UserController
  before_action :set_like, except: %i[create]

  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    if @like.save
      redirect_to user_root_path, notice: 'Post Liked'
    else
      redirect_to user_root_path, alert: 'Like could not be created'
    end
  rescue ActiveRecord::RecordNotUnique
    @like = Like.find_by!(user: current_user, post_id: params[:post_id])
    @like.destroy
    redirect_to user_root_path, notice: 'Like removed'
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post_id])
    if @like&.destroy
      redirect_to user_root_path, notice: 'Like removed'
    else
      redirect_to user_root_path, alert: 'Like could not be removed'
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end
end
