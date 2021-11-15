class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    post_index_path # ログイン後に遷移するpathを設定,一度ログインすると登録ページもログインページも行かずindexのページに行く
  end
    
  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :user_image, :email, :uid,  :provider])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :user_image, :email])
  end
end
