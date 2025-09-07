class EntriesController < ApplicationController
  def new
    @entry_form = EntryForm.new(start_time: params[:start_time])
  end

  def create
    @entry_form = EntryForm.new(entry_form_params.merge(user_id: current_user.id))

    if @entry_form.save
      redirect_to root_path, notice: "ろぐを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @date = Date.parse(params[:id])
    @event = current_user.events.find_by(start_time: @date.all_day)
    @goal = current_user.goals.find_by(start_time: @date.all_day)
  end

  def edit
    date = Date.parse(params[:id])
    event = current_user.events.find_by(start_time: date.all_day)
    goal = current_user.goals.find_by(start_time: date.all_day)
    @entry_form = EntryForm.new(
      content: event&.content,
      title: goal&.title,
      start_time: date,
      event_id: event&.id,
      goal_id: goal&.id
    )
  end

  def update
    @entry_form = EntryForm.new(entry_form_params.merge(user_id: current_user.id))
    if @entry_form.update
      redirect_to root_path, notice: "ろぐを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def entry_form_params
    params.require(:entry_form).permit(:content, :title, :start_time, :event_id, :goal_id)
  end
end
