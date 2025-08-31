import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slide", "indicator"];
  static values = { 
    currentSlide: { type: Number, default: 0 },
    totalSlides: { type: Number, default: 0 }
  };

  connect() {
    console.log("Carrossel controller conectado!");
    this.initializeCarousel();
  }

  disconnect() {
    console.log("Carrossel controller desconectado!");
  }

  initializeCarousel() {
    // Contar slides automaticamente
    this.totalSlidesValue = this.slideTargets.length;
    console.log(`Carrossel inicializado com ${this.totalSlidesValue} slides`);
    
    // Garantir que o primeiro slide esteja visível
    this.showSlide(0);
  }

  showSlide(slideIndex) {
    if (slideIndex < 0 || slideIndex >= this.totalSlidesValue) {
      return;
    }

    // Ocultar todos os slides
    this.slideTargets.forEach(slide => {
      slide.classList.remove('opacity-100');
      slide.classList.add('opacity-0');
    });

    // Atualizar indicadores
    this.indicatorTargets.forEach(indicator => {
      indicator.classList.remove('bg-opacity-100');
      indicator.classList.add('bg-opacity-50');
    });

    // Mostrar slide atual
    if (this.slideTargets[slideIndex]) {
      this.slideTargets[slideIndex].classList.remove('opacity-0');
      this.slideTargets[slideIndex].classList.add('opacity-100');
    }

    // Atualizar indicador atual
    if (this.indicatorTargets[slideIndex]) {
      this.indicatorTargets[slideIndex].classList.remove('bg-opacity-50');
      this.indicatorTargets[slideIndex].classList.add('bg-opacity-100');
    }

    // Atualizar valor do controller
    this.currentSlideValue = slideIndex;
  }

  next() {
    const nextIndex = (this.currentSlideValue + 1) % this.totalSlidesValue;
    this.showSlide(nextIndex);
  }

  prev() {
    const prevIndex = (this.currentSlideValue - 1 + this.totalSlidesValue) % this.totalSlidesValue;
    this.showSlide(prevIndex);
  }

  goToSlide(event) {
    const slideIndex = parseInt(event.currentTarget.dataset.slide);
    if (!isNaN(slideIndex)) {
      this.showSlide(slideIndex);
    }
  }
}
