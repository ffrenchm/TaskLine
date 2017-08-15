# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $(".fa-plus-square, .fa-window-close").click ->
    $(".new-item-form").toggle()
  $(".toggle-completed").click ->
    if $(".completed-item").css("display") == "none"
      $(".completed-item").css("display" : "flex")
    else
      $(".completed-item").css("display" : "none")
