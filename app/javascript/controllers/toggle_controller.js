import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["inputField", "toggle"];
  connect() {
    this.updateInputField();
  }

  toggle() {
    this.updateInputField();
  }

  updateInputField() {
    const isChecked = this.toggleTarget.checked;
    this.inputFieldTarget.disabled = !isChecked;
    if (!isChecked) {
      this.inputFieldTarget.value = "-1";
    }

    const randomSeedController =
      this.application.getControllerForElementAndIdentifier(
        this.element.closest("[data-controller~='random-seed']"),
        "random-seed"
      );

    if (randomSeedController) {
      randomSeedController[isChecked ? "enableButton" : "disableButton"]();
    }
  }
}
