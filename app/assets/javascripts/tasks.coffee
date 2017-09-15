# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $(".toggle-completed").click ->
    if $(this).parent().children(".completed-task").css("display") == "none"
      $(this).parent().children(".completed-task").css("display" : "flex")
    else
      $(this).parent().children(".completed-task").css("display" : "none")
  $(".toggle-more").click ->
    $(this).parent().children(".task-more").slideToggle(100)
  $("#task_repeat").click ->
    $(".every-field").slideToggle(150)
  $(".tickbox").click ->
    if $(this).parent().parent().hasClass("task")
      $(this).parent().parent().removeClass("task").addClass("completed-task")
    else
      $(this).parent().parent().removeClass("completed-task").addClass("task")
  $(".delete-task").click ->
    $(this).parent().parent().toggle()
