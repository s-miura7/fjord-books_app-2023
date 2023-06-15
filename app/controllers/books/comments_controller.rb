# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_book, only: %i[create destroy]

  def create
    comment = @book.comments.build(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @error_comment = comment
      render 'books/show', status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    raise
    if comment.destroy
      redirect_to book_url(@book), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render book_url(@book), status: :unprocessable_entity
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
