class CalendarController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ] # この行を追加
  def index
    if current_user
      @events = Event.all.where(user: current_user)
      @goals = Goal.all.where(user: current_user)
      @calendar_items = @events + @goals
    else
      @latest_changelog = Changelog.order(published_on: :desc).first
    end
  end
end
