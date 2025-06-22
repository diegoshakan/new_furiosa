import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"]; // Define o elemento alvo (menu)

  toggle() {
    this.menuTarget.classList.toggle("hidden"); // Alterna a classe "hidden"
  }
}
