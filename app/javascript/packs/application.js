// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import Raty from "raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on("ajax:success", ".favorite-btn", function(event, data) {
  console.log("Ajaxリクエスト成功", data);
  var bookId = data.book_id;
  var favoritesCount = data.favorites_count;

  $("#book_" + bookId).find(".favorites-count").html(favoritesCount);
  $("#book_" + bookId).find(".favorite-btn").replaceWith(data.favorite_button_html);
});


window.$ = window.jQuery = require('jquery');