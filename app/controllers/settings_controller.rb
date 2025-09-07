class SettingsController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_setting_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :copy_format, :good_new_character_limit)
  end
end
