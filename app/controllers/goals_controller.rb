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

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to @goal, notice: "目標を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to root_path, notice: "目標を削除しました。", status: :see_other
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :start_time)
  end
end
