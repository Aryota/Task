class TasksController < ApplicationController
  def index
    @tasks =Task.all
  end

  def show
    @task =Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task　= Task.find(params[:id])
  end

  def update
    task= Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice:"タスク「#{task.name}」を更新しました。"
  end
  def create
    task =Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスクを「#{task._name}」登録"
  end

  private

  def task_params
    params.require(:task).permit(:_name, :_description)
  end

end
