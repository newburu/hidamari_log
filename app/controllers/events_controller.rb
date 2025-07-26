class EventsController < ApplicationController
  def new
    @event = Event.new(start_time: params[:start_time])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path, notice: "Good & Newを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:content, :start_time)
  end
end
