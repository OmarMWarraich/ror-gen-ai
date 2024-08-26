import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["toggle", "menu"];

  connect() {
    this.showMenu = this.showMenu.bind(this);
    this.hideMenu = this.hideMenu.bind(this);
  }

  showMenu() {
    this.menuTarget.classList.add("show");
  }

  hideMenu(event) {
    if (!this.element.contains(event.relatedTarget)) {
      this.menuTarget.classList.remove("show");
    }
  }
}
