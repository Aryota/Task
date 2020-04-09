class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # 発想は間違ってないですが、もうちょっときれいに書けそうです。
    # enumを使う実装に変えたと思うのでそれも踏まえて書き直してみてください
    #  if文の複雑さを解消できれば良いです。

    # これってpaginationちゃんとできてます？？
    # コード見る感じうまくできてなさそうな気がしますが、、
    @show = params[:show]
    if @show == "all"
      @tasks = Task.all
    elsif @show == "completed"
      @tasks = Task.where(completed: 1)
    else
      @tasks = Task.where(completed: 0)
    end
    @q = current_user.tasks.ransack(params[:q])
    @tasks_page = @q.result(distinct: true).page(params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @tasks_page.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def show
    @task = Task.find(params[:id])
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
      redirect_to tasks_url, notice:"タスク「#{@task.name}」を更新できませんでした。"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice:"タスクを「#{@task.name}」削除しました"
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    # これもこの次のif文に混ぜて良いと思います
    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスクを「#{@task.name}」登録しました"
    else
      render :new
    end
  end

  # これはconfirmだけで良さそう
  # どうしても書くのであればどちらかというとconfirm_creationになると思います
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :descriptionm, :image, :completed, :priority, :content)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
