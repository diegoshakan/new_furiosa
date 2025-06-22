# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    @user.build_address unless @user.address
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Perfil atualizado!"
    else
      render :edit
    end
  end

  def my_announcements
    @q = current_user.announcements.ransack(params[:q])
    @announcements = @q.result(distinct: true).order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :fantasy_name, :email, address_attributes: [:street, :city, :state, :cep])
  end
end
