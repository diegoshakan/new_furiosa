# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!, :set_user

  def show
  end

  def edit
    @user.build_address unless @user.address
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Perfil atualizado!"
    else
      render :edit
    end
  end

  def my_announcements
    @q = current_user.announcements.includes(:images_attachments, :category, :subcategory).ransack(params[:q])
    @announcements = @q.result(distinct: true).order(created_at: :desc)
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :fantasy_name, :email, address_attributes: [:street, :city, :state, :zipcode])
  end
end
