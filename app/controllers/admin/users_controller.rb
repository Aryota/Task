class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録をしました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to tasks_url, notice: "タスクを「##{user.name}」削除しました"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmaｓtion)
    end

    def require_admin
      redirect_to root_url unless current_user.admin?
    end
end
