import { Application } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js";

import HelloController from "./controllers/hello_controller.js";

window.Stimulus = Application.start();

Stimulus.register("hello", HelloController)
