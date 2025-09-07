import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-counter"
export default class extends Controller {
  static targets = [ "input", "output" ]

  connect() {
    this.count()
  }

  count() {
    this.outputTarget.textContent = `${this.inputTarget.value.length} 文字`
  }
}
