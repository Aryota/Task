class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # binding.pry
    if params[:q].present?
      tasks = current_user.tasks
    else
      tasks = params[:sort] ? tasks_sort_by_params : current_user.tasks.doing
    end
    @q = tasks.ransack(params[:q])
    @tasks_page = @q.result(distinct: true).page(params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @tasks_page.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice:"タスク「#{@task.name}」を更新しました。"
    else
      redirect_to tasks_url, notice:"タスクを更新できませんでした。"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice:"タスクを「#{@task.name}」削除しました"
  end

  def create
    time_start = Date.new(params[:task]["start_at(1i)"].to_i,
                          params[:task]["start_at(2i)"].to_i,
                          params[:task]["start_at(3i)"].to_i)
    time_end = Date.new(params[:task]["end_at(1i)"].to_i,
                        params[:task]["end_at(2i)"].to_i,
                        params[:task]["end_at(3i)"].to_i)
    @task = Task.new(task_params.merge(user_id: current_user.id, start_at: time_start, end_at: time_end))
    if params[:back].blank? && @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスクを「#{@task.name}」登録しました"
    else
      render :new
    end
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :image, :completed, :priority, :content, :end_at)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def tasks_sort_by_params
    return current_user.tasks.done if params[:sort] == 'completed'

    current_user.tasks.all
  end
end
