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

  private

  def entry_form_params
    params.require(:entry_form).permit(:content, :title, :start_time)
  end
end
