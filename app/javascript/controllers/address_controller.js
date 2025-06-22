import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["state", "city"]; // Define os elementos alvo

  loadCities() {
    const stateId = this.stateTarget.value;

    if (stateId) {
      fetch(`/addresses/cities?state=${stateId}`) // Faz uma requisição para buscar as cidades
        .then((response) => response.json())
        .then((data) => {
          this.cityTarget.innerHTML = ""; // Limpa as opções anteriores
          data.forEach((city) => {
            const option = document.createElement("option");
            option.value = city;
            option.textContent = city;
            this.cityTarget.appendChild(option);
          });
        });
    } else {
      this.cityTarget.innerHTML = ""; // Limpa as opções se nenhum estado for selecionado
    }
  }
}
