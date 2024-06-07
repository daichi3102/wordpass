// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ['content']

  connect() {
    this.loadContent(this.element.querySelector('[data-tabs-target="profile"]').dataset.url)
  }

  loadContent(url) {
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html
      })
      .catch(error => {
        console.error('There has been a problem with your fetch operation:', error)
      })
  }

  showProfile(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(event.currentTarget.dataset.url)
  }

  showAi(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(event.currentTarget.dataset.url)
  }

  showMakes(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(event.currentTarget.dataset.url)
  }

  showLikes(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(event.currentTarget.dataset.url)
  }

  setActiveTab(tab) {
    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('tab-active'))
    tab.classList.add('tab-active')
  }
}
