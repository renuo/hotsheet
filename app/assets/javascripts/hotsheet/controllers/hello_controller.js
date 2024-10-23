import {
  Controller,
} from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js";

export default class extends Controller {
  connect () {
    console.log("Hello!")
  }
}
