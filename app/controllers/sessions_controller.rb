class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    # OmniAuthから渡された認証情報を取得
    auth_hash = request.env["omniauth.auth"]

    # ユーザーを検索または作成
    user = User.find_or_create_from_auth_hash(auth_hash)

    # sessionにユーザーIDを保存
    session[:user_id] = user.id

    redirect_to root_path, notice: "ログインしました。"
  end

  def destroy
    # sessionからユーザーIDを削除
    session[:user_id] = nil

    redirect_to root_path, notice: "ログアウトしました。"
  end
end
