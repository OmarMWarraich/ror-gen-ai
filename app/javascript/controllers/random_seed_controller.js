import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="random-seed"
export default class extends Controller {
  static targets = ["inputField", "button"];
  populate() {
    const randomNumber = Math.floor(Math.random() * 9999999999);
    this.inputFieldTarget.value = randomNumber;
  }

  disableButton() {
    this.buttonTarget.disabled = true;
  }

  enableButton() {
    this.buttonTarget.disabled = false;
  }
}
