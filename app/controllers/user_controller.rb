class UserController < ApplicationController
    before_action :user_get, only: [:show, :edit]
    def show

    end

    def edit

    end

    private
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
