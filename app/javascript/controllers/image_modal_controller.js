import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["thumbnail"]
  
  connect() {
    console.log("Image modal controller connected")
    this.currentIndex = 0
    this.images = []
    this.modal = document.getElementById('imageModal')
    this.modalImage = document.getElementById('modalImage')
    this.imageCounter = document.getElementById('imageCounter')
    
    // Coletar todas as imagens do anúncio
    this.collectImages()
    
    // Adicionar event listeners para teclado
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener('keydown', this.handleKeydown)
    
    // Tornar o controller global para acesso de outros elementos
    window.imageModalController = this
  }
  
  disconnect() {
    document.removeEventListener('keydown', this.handleKeydown)
    window.imageModalController = null
  }
  
  collectImages() {
    // Coletar URLs das imagens dos thumbnails
    const thumbnails = document.querySelectorAll('[data-image-url]')
    thumbnails.forEach((thumbnail, index) => {
      this.images.push({
        url: thumbnail.dataset.imageUrl,
        index: index
      })
    })
    console.log("Collected images:", this.images)
  }
  
  openModal(event) {
    console.log("Opening modal", event)
    const clickedImage = event.currentTarget
    this.currentIndex = parseInt(clickedImage.dataset.imageIndex)
    
    console.log("Current index:", this.currentIndex)
    this.showImage()
    this.modal.classList.remove('hidden')
    document.body.style.overflow = 'hidden' // Prevenir scroll da página
  }
  
  closeModal() {
    this.modal.classList.add('hidden')
    document.body.style.overflow = 'auto' // Restaurar scroll da página
  }
  
  nextImage() {
    if (this.currentIndex < this.images.length - 1) {
      this.currentIndex++
    } else {
      this.currentIndex = 0 // Volta para a primeira imagem
    }
    this.showImage()
  }
  
  previousImage() {
    if (this.currentIndex > 0) {
      this.currentIndex--
    } else {
      this.currentIndex = this.images.length - 1 // Vai para a última imagem
    }
    this.showImage()
  }
  
  showImage() {
    if (this.images[this.currentIndex]) {
      this.modalImage.src = this.images[this.currentIndex].url
      if (this.imageCounter) {
        this.imageCounter.textContent = this.currentIndex + 1
      }
    }
  }
  
  handleKeydown(event) {
    if (this.modal.classList.contains('hidden')) return
    
    switch(event.key) {
      case 'Escape':
        this.closeModal()
        break
      case 'ArrowLeft':
        this.previousImage()
        break
      case 'ArrowRight':
        this.nextImage()
        break
    }
  }
}