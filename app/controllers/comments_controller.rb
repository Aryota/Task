class CommentsController < ApplicationController
  before_action :comment

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to task_path(comment.task_id), notice:"コメントを更新しました"
    else
      redirect_to task_path(comment.task_id), notice:"コメントが更新できませんでした"
    end
  end

  def create
    if @comment.save
      redirect_to task_path(comment.task_id), notice:"コメントを更新しました"
    else
      redirect_to task_path(comment.task_id), notice:"コメント投稿を失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to task_path(comment.task_id), notice:"コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :task_id)
  end

  def comment
    @comment = Comment.find(params[:id])
  end
end
