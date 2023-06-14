class Books::CommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    if book.comments.build(content: comment_params[:content], user: current_user).save
      redirect_to book_url(book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render book_url(reoprt), status: :bad_request
    end
  end
  private

  def comment_params
      params.require(:comment).permit(:content)
  end
end
