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

        const previousValue = this.readonlyAttributeTarget.innerText.trim();
        const newValue = this.attributeFormInputTarget.value;
        if (previousValue && previousValue === newValue) {
            this.readonlyAttributeTarget.style.display = 'block';
            this.attributeFormTarget.style.display = 'none';
            return;
        }

        // It's important to use requestSubmit() instead of simply submit() as the latter will circumvent the
        // Turbo mechanism, causing the PATCH request to be submitted as HTML instead of TURBO_STREAM
        this.attributeFormInputTarget.form.requestSubmit();
    }
}
