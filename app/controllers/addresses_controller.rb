class AddressesController < ApplicationController
  def cities
    state = params[:state]
    cities = Address.where(state: state).distinct.pluck(:city)
    render json: cities # 'render json' porque está retornando para um script JavaScript.
  end
end
