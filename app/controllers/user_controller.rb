class UserController < ApplicationController
    before_action :user_get, only: [:show, :edit, :update]
    before_action :autheticate_partial_user
    def show

    end

    def edit
        
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "更新できました"
            redirect_to user_path(@user)
        else
            flash[:notice] = "更新に失敗しました"
            render :edit
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :user_image)
    end

    def user_get
        @user = User.find_by(id: params[:id])
    end

    def autheticate_partial_user
        if @user.id != current_user.id
            flash[:notice] = "権限がありません"
            redirect_to post_index_path
          end
    end
end
