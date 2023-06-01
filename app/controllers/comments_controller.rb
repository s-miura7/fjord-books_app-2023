class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[ create update]
  before_action :set_comment, only: %i[ destroy update]

  def create
    render :new, status: :unprocessable_entity if comment_params[:content].nil?
    @comment = @commentable.comment.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render @commentable, status: 400
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to report_url(params[:id]), notice:  t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      render @commentable, status: 400
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
