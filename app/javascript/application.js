// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"

Rails.start()

// import * as ActiveStorage from "@rails/activestorage"
// ActiveStorage.start()
//= require jquery3
//= require popper
//= require bootstrap
//= require activestorage

// import 'bootstrap/dist/js/bootstrap'
// import 'bootstrap/dist/css/bootstrap'

import "./activestorage.js"
import "./direct_uploads.js"