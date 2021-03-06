class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    tasks = if params[:q].present?
              current_user.tasks
            else
              params[:sort] ? tasks_sort_by_params : current_user.tasks.doing
            end
    @q = tasks.ransack(params[:q])
    @tasks_page = @q.result(distinct: true).page(params[:page])
    @userstask = UsersTask
    @task_model = Task
    respond_to do |format|
      format.html
      format.csv { send_data @tasks_page.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def show
    @userstask = UsersTask.find_by(task_id: @task.id, user_id: current_user.id).is_owner
    @task_model = Task
  end

  def new
    @task = Task.new
  end

  def edit; end

  def update
    if @task.update(task_params)
      if params[:task]["user_ids"].present?
        UsersTask.where(task_id: @task.id).destroy_all
        map_task_and_users
      else
        redirect_to edit_task_path, notice: "ユーザーを選択してください！"
      end
    else
      redirect_to tasks_url, notice: "タスクを更新できませんでした。"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスクを「#{@task.name}」削除しました"
  end

  def create
    @task = Task.new(task_params)
    if params[:back].blank? && @task.save
      if params[:task]["user_ids"].present?
        map_task_and_users
      else
        redirect_to new_task_path, notice: "ユーザーを選択してください！"
      end
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
      params.require(:task).permit(:name, :description, :image, :completed, :priority, :content, :start_at, :end_at)
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def tasks_sort_by_params
      return current_user.tasks.done if params[:sort] == "completed"

      current_user.tasks.all
    end

    def map_task_and_users
      params[:task]["user_ids"].each do |ui|
        UsersTask.create(user_id: ui, task_id: @task.id, is_owner: (current_user.id == ui.to_i).to_s)
      end
      redirect_to @task, notice: "タスクを「#{@task.name}」登録しました"
    end
end
