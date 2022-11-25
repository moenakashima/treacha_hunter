// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// ターボリンク無効化
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// FontAwesome
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
ActiveStorage.start()
// ターボリンク無効化
// Turbolinks.start() 
