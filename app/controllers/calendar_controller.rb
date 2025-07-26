class CalendarController < ApplicationController
  def index
    @events = Event.all
    @goals = Goal.all
    @calendar_items = @events + @goals
  end
end
