class PostController < ApplicationController
    before_action :post_get, only: [:edit, :show, :update, :destroy]
    before_action :autheticate_partial_user, only: [:edit, :destroy]

    def index
        @janles = Janle.all
        @posts = Post.all.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        janle_list = params[:post][:janle]
        if @post.save
            @post.save_janle(janle_list)
            flash[:notice] = "投稿ができました"
            redirect_to post_index_path
          else
            flash[:alert] = "投稿に失敗しました"
            render :new 
        end
    end

    

    def edit
        
    end

    def show
        
    end

    def update
        janle_list = params[:post][:janle]
        if @post.update!(post_params)
            @post.save_janle(janle_list)
            flash[:notice] = "更新できました"
            redirect_to post_path(@post)
        else
            flash[:alert] = "更新に失敗しました"
            render :edit
        end
    end 

    def destroy
        if @post.destroy
            flash[:notice] = "削除ができました"
            redirect_to post_index_path 
          else
            flash[:alert] =  "削除に失敗しました"
            render post_path(@post)
        end
    end

    private
    
    def post_get
        @post = Post.find_by(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:content, :title, :post_image, :user_id)
    end


    def autheticate_partial_user
        if @post.user_id != current_user.id
          flash[:notice] = "権限がありません"
          redirect_to post_index_path
        end
    end
    

   
end
