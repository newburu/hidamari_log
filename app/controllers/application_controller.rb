class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  helper_method :current_user, :guest_user?
  before_action :set_beginning_of_week

  private

  def authenticate_user!
    # もしログインしていなければ（current_userがいなければ）
    unless current_user
      # トップページに戻して、「ログインが必要です」というメッセージを表示します
      redirect_to root_path, alert: "ログインが必要です。"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def guest_user?
    current_user&.email == "guest@example.com"
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
