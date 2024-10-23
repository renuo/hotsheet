import { Application } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js";

import EditableAttributeController from "./controllers/editable_attribute_controller.js";

window.Stimulus = Application.start();

Stimulus.register("editable-attribute", EditableAttributeController)
