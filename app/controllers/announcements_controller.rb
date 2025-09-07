# app/controllers/announcements_controller.rb
class AnnouncementsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_announcement, only: [ :show, :edit, :update, :destroy ]

  def index
    @q = Announcement.ransack(params[:q]) # Cria o objeto de busca com os parâmetros
    @announcements = @q.result.includes(:images_attachments, :user, :likes) # Executa a busca e inclui associações

    # Limpa os parâmetros de pesquisa da sessão quando voltar para a listagem
    session.delete(:last_search_params) if session[:last_search_params].present?
  end

  def show
    # Armazena os parâmetros de pesquisa na sessão se vier da página de listagem
    if request.referer&.include?("announcements")
      referer_uri = URI(request.referer)
      if referer_uri.query.present?
        session[:last_search_params] = referer_uri.query
      end
    end

    @comments = @announcement.comments
  end

  def new
    redirect_to new_address_path unless current_user.address.present?
    @announcement = current_user.announcements.build
  end

  def create
    @announcement = current_user.announcements.build(announcement_params)
    if @announcement.save
      redirect_to @announcement, notice: "Anúncio criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # A ação edit já tem o @announcement definido pelo set_announcement
    # Verificamos se o usuário atual é o dono do anúncio
    redirect_to announcements_path, alert: "Você não tem permissão para editar este anúncio." unless @announcement.user == current_user
  end

  def update
    if @announcement.user == current_user && @announcement.update(announcement_params)
      redirect_to @announcement, notice: "Anúncio atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @announcement.user == current_user
      @announcement.destroy
      redirect_to announcements_path, notice: "Anúncio excluído com sucesso!"
    else
      redirect_to announcements_path, alert: "Você não tem permissão para excluir este anúncio."
    end
  end

  private

  def set_announcement
    @announcement = Announcement.includes(:user, :category, :subcategory, :images_attachments).find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :description, :code, :price, :category_id, :subcategory_id, images: [])
  end
end
