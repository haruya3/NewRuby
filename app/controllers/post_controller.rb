class PostController < ApplicationController
    before_action :post_params

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "投稿を作成しました"
            redirect_to post_index_path
          else
            render :new 
        end
    end

    private
    def post_params
        params.permit(:content, :title, :post_image, :user_id, janle: [])
    end

   
end
