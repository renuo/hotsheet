import "@hotwired/turbo"
import { Application } from "@hotwired/stimulus"
import { NavController } from "./controllers/nav_controller"
import { SheetsController } from "./controllers/sheets_controller"

const app = Application.start()

app.register("nav", NavController)
app.register("sheets", SheetsController)
