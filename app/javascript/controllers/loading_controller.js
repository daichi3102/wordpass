// app/javascript/controllers/loading_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["modal", "submit"];

  connect() {
    if (this.hasSubmitTarget) {
      this.submitTarget.addEventListener('click',this.show.bind(this));
    }

    document.addEventListener("turbolinks:load", () => {
      const flashSuccess = document.getElementById("flash-message");
      if (flashSuccess) {
        this.hide();
      }
    });
  }

  show() {
    this.modalTarget.showModal();
  }

  hide() {
    this.modalTarget.close();
  }
}