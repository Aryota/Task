class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to task_path(comment.task_id), notice:"コメントを更新しました"
    else
      redirect_to task_path(comment.task_id), notice:"コメントを投稿を失敗しました"
    end
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    redirect_to task_path(comment.task_id), notice:"コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:task_id)
  end
end
