# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report, only: %i[create destroy]
  def create
    if @report.comments.build(content: comment_params[:content], user: current_user).save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render report_url(@reoprt), status: :bad_request
    end
  end

  def destroy
    if current_user.comments.find(params[:id]).destroy
      redirect_to report_url(@report), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render report_url(@report), status: :bad_request
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
