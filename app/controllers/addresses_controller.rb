class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update ]

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = current_user.build_address
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = current_user.build_address(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to new_announcement_path, notice: "Endereço adicionado com sucesso." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to profile_path, notice: "Endereço atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def cities
    state = params[:state]
    cities = Address.where(state: state).distinct.pluck(:city)
    render json: cities # 'render json' porque está retornando para um script JavaScript.
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = current_user.address if current_user.address.present?
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.expect(address: [ :state, :city, :neighborhood, :street, :number, :zipcode, :reference_point ])
    end
end
