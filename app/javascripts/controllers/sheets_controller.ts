import { Controller } from "@hotwired/stimulus"

export class SheetsController extends Controller {
  static readonly arrowKeys = ["ArrowDown", "ArrowLeft", "ArrowRight", "ArrowUp"]

  private readonly csrf = document.querySelector<HTMLMetaElement>("meta[name=csrf-token]")?.content

  private flash = document.querySelector(".flash")!
  private input = document.createElement("input")
  private columns = this.element.querySelectorAll(".column")
  private cell = this.input as HTMLElement
  private cells: Record<string, HTMLElement> = {}
  private columnNames: string[] = []
  private ids: string[] = []
  private editMode = false
  private prevValue = ""

  /** Sends the new value to the server. */
  private readonly update = () => {
    const [x, y] = this.getPosition()
    const {
      cell,
      prevValue,
      input: { value },
    } = this

    if (value === prevValue) return

    fetch(`${location.pathname}/${this.ids[y]}?column_name=${this.columnNames[x]}&value=${value}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrf ?? "",
      },
    })
      .then((res) => res.json())
      .then((error?: string) => {
        if (error) {
          const flash = document.createElement("span")

          flash.classList.add("alert")
          flash.innerHTML = error
          cell.innerHTML = prevValue
          cell.click()

          this.flash.replaceChildren(flash)
          setTimeout(() => flash.remove(), 5000)
        }
      })
  }

  /** Returns the position of the focused cell. */
  private readonly getPosition = (): number[] => this.cell.dataset.xy!.split(",").map(Number)

  /** Sets the cell and focuses it. */
  private readonly setCell = (cell?: HTMLElement): void => {
    if (!cell) return
    if (this.editMode) {
      this.update()
      this.editMode = false
      this.cell.innerHTML = this.input.value
      this.cell.scrollLeft = 0
    }

    this.cell = cell
    cell.focus()
  }

  /** Enables edit mode for the focused cell. */
  private readonly enableEditMode = (): void => {
    if (!this.cell.classList.contains("readonly")) {
      this.editMode = true
      this.prevValue = this.input.value = this.cell.innerHTML
      this.cell.replaceChildren(this.input)
      this.input.select()
    }
  }

  /** Focuses the clicked cell or makes it editable if it's already focused. */
  private readonly focus = (event: MouseEvent): void => {
    const cell = event.target as HTMLElement

    if (cell !== this.cell && cell.classList.contains("cell")) {
      this.setCell(event.target as HTMLElement)
    } else if (!this.editMode) {
      this.enableEditMode()
    }
  }

  /** Moves the focus to the next cell or makes it editable. */
  private readonly moveFocus = (event: KeyboardEvent): void => {
    const { key } = event

    if (this.editMode) {
      if (key === "Enter") {
        const [x, y] = this.getPosition()

        this.setCell(this.cells[`${x},${y + 1}`])
      }
    } else if (key === "Enter") {
      this.enableEditMode()
    } else if (key === "Tab") {
      event.preventDefault()
      document.querySelector<HTMLElement>(".sheets .active")!.focus()
    } else if (SheetsController.arrowKeys.includes(key)) {
      const offset =
        key === "ArrowDown" ? [0, 1]
        : key === "ArrowRight" ? [1, 0]
        : key === "ArrowUp" ? [0, -1]
        : [-1, 0]
      const [x, y] = this.getPosition().map((v, i) => v + offset[i])
      let cell = this.cells[`${x},${y}`]

      if (offset[0]) {
        for (let i = x; !cell && i !== 0 && i !== this.columnNames.length; i += offset[0]) {
          cell = this.cells[`${i},${y}`]
        }
      }

      this.setCell(cell)
    }
  }

  private readonly addCells = (): void => {
    this.cells = {}
    this.ids = [...this.element.querySelectorAll<HTMLElement>(".column:first-child .readonly")].map(
      (cell) => cell.innerHTML,
    )

    this.element.querySelectorAll<HTMLElement>(".cell[data-xy]").forEach((cell) => {
      this.cells[cell.dataset.xy!] = cell

      cell.addEventListener("click", this.focus)
      cell.addEventListener("keydown", this.moveFocus)
    })
  }

  readonly connect = (): void => {
    this.columnNames = [...this.element.querySelectorAll<HTMLElement>(".header")].map(
      (header) => header.dataset.name!,
    )
    this.addCells()
  }

  readonly loadMore = (event: MouseEvent): void => {
    const target = event.target as HTMLElement

    fetch(`${location.pathname}?page=${target.dataset.page}`)
      .then((res) => res.text())
      .then((html) => {
        const table = document.createElement("div")

        table.innerHTML = html
        table.querySelectorAll(".column").forEach((column, index) => {
          this.columns[index].append(...[...column.children].slice(1))
        })
        this.addCells()

        const moreButton = table.querySelector(".load-more")

        if (moreButton) {
          this.element.querySelector(".load-more")!.replaceWith(moreButton)
        } else {
          this.element.querySelector(".load-more")!.remove()
        }
      })
  }
}
