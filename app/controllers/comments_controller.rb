class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.board
    else
      redirect_back(fallback_location: boards_path,
      flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      })
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.board, flash: { danger: 'コメントが削除されました' }
  end

  private

  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
