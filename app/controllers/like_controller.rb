class LikeController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      like = current_user.likes.new(post_id: @post.id) ##中間テーブルに直接登録する。current_user.postsは、current_userのidに関連したpostを配列にして取得。
      like.save ##current_user.postsを使うのは、postの情報を取得する際に使うぐらい。なかなか、中間テーブルに保存する際は1対多を使って保存するのがほとんど。
    end

    def destroy
      @post = Post.find(params[:post_id])
      like = current_user.likes.find_by(post_id: @post.id)
      like.destroy
    end
end
