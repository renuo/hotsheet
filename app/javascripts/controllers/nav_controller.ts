import { Controller } from "@hotwired/stimulus"

export class NavController extends Controller {
  private sheets: HTMLElement[] = []

  private readonly moveFocus = (ev: KeyboardEvent): void => {
    const { key } = ev

    if (key === "Tab") {
      ev.preventDefault()
      document.querySelector<HTMLElement>(`.table .cell[data-xy]`)?.click()
    } else if (key === "ArrowRight") {
      this.sheets[Number((ev.target as HTMLElement).dataset.x) + 1]?.focus()
    } else if (key === "ArrowLeft") {
      this.sheets[Number((ev.target as HTMLElement).dataset.x) - 1]?.focus()
    }
  }

  readonly connect = (): void => {
    this.sheets = [...this.element.querySelectorAll<HTMLElement>("[data-x]")]

    this.sheets.forEach((sheet) => {
      if (sheet.classList.contains("active")) {
        sheet.focus()
      }

      sheet.addEventListener("keydown", this.moveFocus)
    })
  }
}
