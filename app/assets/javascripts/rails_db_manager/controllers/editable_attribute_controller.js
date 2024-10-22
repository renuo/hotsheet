import {
    Controller,
} from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js";

export default class extends Controller {
    static targets = [
      'readonlyAttribute',
      'attributeForm',
      'attributeFormInput'
    ];

    displayInputField() {
        this.readonlyAttributeTarget.style.display = 'none';
        this.attributeFormTarget.style.display = 'block';
        this.attributeFormInputTarget.focus();
    }

    submitForm(event) {
        // Prevent standard submission triggered by Enter press
        event.preventDefault();

        if (this.readonlyAttributeTarget.innerText.trim() === this.attributeFormInputTarget.value) {
            this.readonlyAttributeTarget.style.display = 'block';
            this.attributeFormTarget.style.display = 'none';

            return;
        }

        // It's important to use requestSubmit() instead of simply submit() as the latter will circumvent the
        // Turbo mechanism, causing the PATCH request to be submitted as HTML instead of TURBO_STREAM
        this.attributeFormInputTarget.form.requestSubmit();
    }
}
