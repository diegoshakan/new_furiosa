# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @announcement = Announcement.find(params[:announcement_id])
    @comment = @announcement.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @announcement, notice: "Comentário adicionado!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "announcements/comment_form", locals: { announcement: @announcement, comment: @comment }) }
        format.html { render "announcements/show" }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
