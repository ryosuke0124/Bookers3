class ApplicationController < ActionController::Base

	#以下を追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
   	user_path(current_user) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
  protected

  def configure_permitted_parameters
   #strong parametersを設定し、usernameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
