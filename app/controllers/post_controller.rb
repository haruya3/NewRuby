class PostController < ApplicationController
    before_action :post_params
    before_action :post_get, only: [:edit, :show, :update, :destroy]
    before_action :autheticate_partial_user, only: [:edit, :show, :update, :destroy]

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

    def edit

    end

    def show
        
    end

    def update

    end 

    def destroy

    end

    private
    def post_params
        params.permit(:content, :title, :post_image, :user_id, janle: [])
    end

    def post_get
        @post = Post.find_by(user_id: current_user.id)
    end

    def autheticate_partial_user
        if @post.user_id != current_user.id
          flash[:notice] = "権限がありません"
          redirect_to post_index_path
        end
    end
    

   
end
