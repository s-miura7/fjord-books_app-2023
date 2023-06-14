class Books::CommentsController < ApplicationController
  before_action :set_book, only: %i[create destroy]
  def create
    if @book.comments.build(content: comment_params[:content], user: current_user).save
      redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render book_url(reoprt), status: :bad_request
    end
  end

  def destroy
    if current_user.comments.find(params[:id]).destroy
      redirect_to book_url(@book), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render book_url(params[:id]), status: :bad_request
    end
  end
  private

  def comment_params
      params.require(:comment).permit(:content)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
