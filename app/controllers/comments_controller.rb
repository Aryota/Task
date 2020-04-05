class CommentsController < AppricationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to tasks/index
  end

  # def destroy
  #   @comment.destroy
  #   redirect_to tasks_url, notice:"タスクを「#{@comment.content}」削除しました"
  # end
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
