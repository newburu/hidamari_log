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

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Good & Newを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Good & Newを削除しました。", status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:content, :start_time)
  end
end
