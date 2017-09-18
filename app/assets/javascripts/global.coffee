$(document).on 'turbolinks:load', ->
  $(".phone-nav").css("display" : "none")
  $(".nav-toggle").click ->
    $(".phone-nav").slideToggle(100)
