# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @announcement = Announcement.find(params[:announcement_id])
    @like = @announcement.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @announcement }
      end
    end
  end
end
