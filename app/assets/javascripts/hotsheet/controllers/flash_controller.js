import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

export default class extends Controller {
  close() {
    this.element.addEventListener("animationend", () => { this.element.remove(); });
    this.element.classList.add("closing");
  }
}
