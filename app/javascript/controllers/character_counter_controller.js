import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "count", "limit", "counter" ]

  connect() {
    this.update()
  }

  update() {
    const length = this.inputTarget.value.length
    const limit = parseInt(this.limitTarget.textContent)

    this.countTarget.textContent = length

    if (length > limit) {
      this.counterTarget.classList.add("text-danger")
    } else {
      this.counterTarget.classList.remove("text-danger")
    }
  }
}
