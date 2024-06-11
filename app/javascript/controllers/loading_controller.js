// app/javascript/controllers/loading_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["modal", "submit", "customsubmit"]

  connect() {
    if (this.hasCustomsubmitTarget) {
      this.customsubmitTarget.addEventListener('click', this.show.bind(this))
    }
    if (this.hasSubmitTarget) {
      this.submitTarget.addEventListener('click', this.show.bind(this))
    }
  }

  show() {
    this.modalTarget.showModal();
  }

  hide() {
    this.modalTarget.close();
  }
}