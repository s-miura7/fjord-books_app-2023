# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @commentable.comment.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render @commentable, status: :bad_request
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to report_url(params[:id]), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render @commentable, status: :bad_request
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end

def set_commentable
  @commentable = Module.const_get(comment_params[:commentable_type]).find(comment_params[:commentable_id])
end

def set_comment
  @comment = Comment.find(params[:id])
end
