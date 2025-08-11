class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def terms
  end

  def privacy
  end

  def changelog
    @changelogs = Changelog.all.order(published_on: :desc) # 公開日の新しい順で取得
  end
end
