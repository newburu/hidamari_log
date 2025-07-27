class CalendarController < ApplicationController
  def index
    @events = Event.all.where(user: current_user)
    @goals = Goal.all.where(user: current_user)
    @calendar_items = @events + @goals
  end
end
