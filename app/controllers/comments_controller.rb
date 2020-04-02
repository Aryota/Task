class CommentsController < AppricationController
  # def index
  #   @comments = Comment.all
  # end
  # def new
  #   @comment = Comment.new(comment_params)
  #   if @comment.save
  #     redirect_back(fallback_location: root_path)
  #   else
  #     redirect_back(fallback_location: root_path)
  #   end
  # end
  def create
    @comment = Comment.new(comment_params)
    @comment.save!
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
