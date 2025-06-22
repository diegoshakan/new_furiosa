class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    session.delete(:user_return_to) || announcements_path || super
  end

  private

  # Armazena a URL atual para redirecionar após o login
  def store_user_location!
    session[:user_return_to] = request.fullpath
  end

  # Define se a URL deve ser armazenada
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
end
