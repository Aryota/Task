class TasksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end
  def create
    task =User.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスクを「#{task.name}」登録"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
