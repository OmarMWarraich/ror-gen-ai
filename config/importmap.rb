# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@popperjs/core/lib/index.js", to: "@popperjs--core--lib--index.js.js" # @2.11.8
pin_all_from "@popperjs/core/lib", under: "@popperjs/core/lib"
pin "bootstrap" # @5.3.3
pin "@popperjs/core/lib", to: "@popperjs--core--lib.js" # @2.11.8
