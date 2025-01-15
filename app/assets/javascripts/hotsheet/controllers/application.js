import { Application } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
import EditableAttributeController from "./controllers/editable_attribute_controller"
import FlashController from "./controllers/flash_controller"

window.Stimulus = Application.start()

Stimulus.register("editable-attribute", EditableAttributeController)
Stimulus.register("flash", FlashController)
