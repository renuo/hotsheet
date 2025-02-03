import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

export default class extends Controller {
  static values = {
    broadcastUrl: String,
    resourceName: String,
    resourceId: Number,
    resourceInitialValue: String
  }

  static targets = ["attributeFormInput"]

  broadcastEditIntent() { // TODO: trigger on input focus
    const headers = {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
    }
    const body = JSON.stringify({
      broadcast: {
        resource_name: this.resourceNameValue,
        resource_id: this.resourceIdValue,
      },
    })

    fetch(this.broadcastUrlValue, { method: "POST", headers, body })
  }

  submitForm(event) {
    // Prevent standard submission triggered by Enter press
    event.preventDefault()

    const newValue = this.attributeFormInputTarget.value
    if (this.resourceInitialValueValue === newValue) return;

    // It's important to use requestSubmit() instead of simply submit() as the latter will circumvent the
    // Turbo mechanism, causing the PATCH request to be submitted as HTML instead of TURBO_STREAM
    this.attributeFormInputTarget.form.requestSubmit()
  }
}
