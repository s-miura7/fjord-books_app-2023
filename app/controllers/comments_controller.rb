# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    if params[:report_id].nil?
      @commentable = Book.find(params[:book_id])
    elsif params[:book_id].nil?
      @commentable = Report.find(params[:report_id])
    end
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render @commentable, status: :bad_request
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to report_url(params[:id]), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render @commentable, status: :bad_request
    end
  end

  private

  def comment_params
      params.require(:comment).permit(:content)
  end
end
