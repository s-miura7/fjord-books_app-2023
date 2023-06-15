# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report, only: %i[create destroy]
  def create
    comment = @report.comments.build(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render report_url(@reoprt), status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    if comment.destroy
      redirect_to report_url(@report), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render report_url(@report), status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_report
    @report = Report.find(params[:report_id])
  end
end
