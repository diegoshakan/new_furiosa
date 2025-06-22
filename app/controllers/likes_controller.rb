# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @announcement = Announcement.find(params[:announcement_id])
    like = @announcement.likes.find_by(user: current_user)

    if like
      like.destroy # Remove a curtida se já existir
    else
      @announcement.likes.create(user: current_user) # Adiciona a curtida
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: announcement_path(@announcement) }
      format.turbo_stream
    end
  end
end
