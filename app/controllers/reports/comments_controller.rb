class Reports::CommentsController < ApplicationController
  def create
    report = Report.find(params[:report_id])
    if report.comments.build(content: comment_params[:content], user: current_user).save
      redirect_to report_url(report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render book_url(reoprt), status: :bad_request
    end
  end
  private

  def comment_params
      params.require(:comment).permit(:content)
  end
end
