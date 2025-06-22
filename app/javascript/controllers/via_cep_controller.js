import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["zipcode", "street", "neighborhood", "city", "state", "number", "referencePoint"];

  connect() {
    console.log("Address controller conectado!");
  }

  async fetchAddress() {
    const cep = this.zipcodeTarget.value.replace(/\D/g, ""); // Remove caracteres não numéricos

    if (cep.length === 8) {
      try {
        const response = await fetch(`https://viacep.com.br/ws/${cep}/json/`);
        if (!response.ok) throw new Error("Erro ao buscar o CEP");

        const data = await response.json();
        console.log("🚀 ~ extends ~ fetchAddress ~ data:", data)
        if (data.erro) throw new Error("CEP não encontrado");

        // Preenche os campos com os dados retornados
        this.streetTarget.value = data.logradouro || "";
        this.neighborhoodTarget.value = data.bairro || "";
        this.cityTarget.value = data.localidade || "";
        this.stateTarget.value = data.uf || "";

        // Desabilita os campos preenchidos automaticamente
        this.streetTarget.readOnly = true;
        this.neighborhoodTarget.readOnly = true;
        this.cityTarget.readOnly = true;
        this.stateTarget.readOnly = true;
      } catch (error) {
        console.error(error);
        alert("Não foi possível buscar o endereço. Verifique o CEP e tente novamente.");
        this.clearFields(); // Limpa os campos em caso de erro
      }
    } else {
      this.clearFields(); // Limpa os campos se o CEP for inválido
    }
  }

  clearFields() {
    // Limpa os campos e habilita novamente
    this.streetTarget.value = "";
    this.neighborhoodTarget.value = "";
    this.cityTarget.value = "";
    this.stateTarget.value = "";

    this.streetTarget.disabled = false;
    this.neighborhoodTarget.disabled = false;
    this.cityTarget.disabled = false;
    this.stateTarget.disabled = false;
  }
}