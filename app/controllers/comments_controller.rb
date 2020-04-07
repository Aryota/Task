class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to tasks_path, notice:"コメントを更新しました"
  end

  # def destroy
  #   @comment.destroy
  #   redirect_to tasks_url, notice:"タスクを削除しました"
  # end
  private

  def comment_params
    params.require(:comment).permit(:content,:task_id)
  end
end
