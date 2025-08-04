class EntriesController < ApplicationController
  def new
    @event = Event.new(start_time: params[:start_time])
    @goal = Goal.new(start_time: params[:start_time])
  end
end
