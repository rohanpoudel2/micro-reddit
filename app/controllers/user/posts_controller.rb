class User::PostsController < UserController
    before_action :set_post, except: [:index, :create]

    def index
        @posts = Post.all
        @new_post = Post.new
        @comment = Comment.new
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to user_root_path, notice: "Post successfully created"
        else
            @posts = Post.all
            @new_post = @post
            @new_comment =
            render :index, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to edit_user_post_path(@post), notice: "Post updated Successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @post.destroy
            redirect_to user_root_path, notice: "Post Deleted Successfully"
        else
            redirect_to user_root_path, notice: "Something went wrong"
        end
    end


    private

    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end
