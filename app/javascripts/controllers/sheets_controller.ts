import { Controller } from "@hotwired/stimulus"

type UpdateResponse = {
  error?: string
  value: string
  x: number
  y: number
}

export class SheetsController extends Controller {
  static readonly arrowKeys = ["ArrowDown", "ArrowLeft", "ArrowRight", "ArrowUp"]

  private readonly csrf = document.querySelector<HTMLMetaElement>("meta[name=csrf-token]")?.content

  private x = 0
  private y = 0
  private columnNames: string[] = []
  private input = document.createElement("input")
  private cell = this.input as HTMLElement
  private cells: HTMLElement[][] = []
  private editMode = false
  private value = ""

  /** Sends the new value to the server. */
  private readonly update = () => {
    const sheet = window.location.pathname
    const id = this.cells[this.y][0].innerHTML
    const params = new URLSearchParams({
      column_name: this.columnNames[this.x],
      from: this.value,
      to: this.input.value,
    })

    fetch(`${sheet}/${id}?${params}&x=${this.x}&y=${this.y}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrf ?? "",
      },
    })
      .then((res) => res.json())
      .then((res: UpdateResponse) => {
        if (res.error) {
          const flash = document.createElement("span")

          flash.classList.add("alert")
          flash.innerHTML = res.error
          this.cells[res.y][res.x].innerHTML = res.value

          document.querySelector(".flash")!.replaceChildren(flash)
          setTimeout(() => flash.remove(), 5000)
        }
      })
  }

  /** Returns the cell at the given position. */
  private readonly getCell = (offsetX: number, offsetY: number): HTMLElement | undefined =>
    this.cells[this.y + offsetY]?.[this.x + offsetX]

  /** Sets the cell and focuses it. */
  private readonly setCell = (cell: HTMLElement): void => {
    if (this.editMode) {
      this.update()
      this.editMode = false
      this.cell.innerHTML = this.input.value
      this.cell.scrollLeft = 0
    }

    this.cell = cell
    cell.focus()
    ;[this.x, this.y] = cell.dataset.xy!.split(",").map(Number)
  }

  /** Enables edit mode for the focused cell. */
  private readonly enableEditMode = (): void => {
    if (!this.cell.classList.contains("readonly")) {
      this.editMode = true
      this.value = this.input.value = this.cell.innerHTML
      this.cell.replaceChildren(this.input)
      this.input.select()
    }
  }

  /** Focuses the clicked cell or makes it editable if it's already focused. */
  private readonly focus = (ev: MouseEvent): void => {
    const cell = ev.target as HTMLElement

    if (cell !== this.cell && cell.classList.contains("cell")) {
      this.setCell(ev.target as HTMLElement)
    } else if (!this.editMode) {
      this.enableEditMode()
    }
  }

  /** Moves the focus to the next cell or makes it editable. */
  private readonly moveFocus = (ev: KeyboardEvent): void => {
    const { key } = ev

    if (this.editMode) {
      if (key === "Enter") {
        const cell = this.getCell(0, 1)

        if (cell) {
          this.setCell(cell)
        }
      }
    } else if (key === "Enter") {
      this.enableEditMode()
    } else if (key === "Tab") {
      ev.preventDefault()
      document.querySelector<HTMLElement>(".sheets .active")!.focus()
    } else if (SheetsController.arrowKeys.includes(key)) {
      const [offsetX, offsetY] =
        key === "ArrowDown" ? [0, 1]
        : key === "ArrowRight" ? [1, 0]
        : key === "ArrowUp" ? [0, -1]
        : [-1, 0]
      const cell = this.getCell(offsetX, offsetY)

      if (cell) {
        this.setCell(cell)
      }
    }
  }

  readonly connect = (): void => {
    this.element.querySelectorAll<HTMLElement>(".cell[data-xy]").forEach((cell) => {
      const [x, y] = cell.dataset.xy!.split(",").map(Number)

      ;(this.cells[y] ??= [])[x] = cell
      cell.addEventListener("click", this.focus)
      cell.addEventListener("keydown", this.moveFocus)
    })

    this.columnNames = [...this.element.querySelectorAll<HTMLElement>(".header")].map(
      (header) => header.dataset.name!,
    )
  }
}
