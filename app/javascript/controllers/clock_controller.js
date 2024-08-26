import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clock"
export default class extends Controller {
  static targets = ["central", "sydney", "islamabad"];

  connect() {
    this.updateTimes();
    this.timer = setInterval(() => this.updateTimes(), 1000);
  }

  disconnect() {
    clearInterval(this.timer);
  }

  updateTimes() {
    // Define time zones
    const centralTimeOptions = { timeZone: "America/Chicago", hour12: true };
    const sydneyTimeOptions = { timeZone: "Australia/Sydney", hour12: true };
    const islamabadTimeOptions = { timeZone: "Asia/Karachi", hour12: true };

    // Get current times
    const centralTime = new Date().toLocaleTimeString(
      "en-US",
      centralTimeOptions
    );
    const sydneyTime = new Date().toLocaleTimeString(
      "en-US",
      sydneyTimeOptions
    );
    const islamabadTime = new Date().toLocaleTimeString(
      "en-US",
      islamabadTimeOptions
    );

    // Update the HTML elements with the current times
    this.centralTarget.innerText = `${centralTime}`;
    this.sydneyTarget.innerText = `${sydneyTime}`;
    this.islamabadTarget.innerText = `${islamabadTime}`;
  }
}
