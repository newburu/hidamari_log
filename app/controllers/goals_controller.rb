class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to root_path, notice: "新しい目標を設定しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :start_time)
  end
end
