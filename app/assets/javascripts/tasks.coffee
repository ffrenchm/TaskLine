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
  $(".tickbox").hover ->
    $(this).toggleClass("tick-transition")
  $(".tickbox").click ->
    if $(this).parent().parent().hasClass("task")
      $(this).parent().parent().removeClass("task").addClass("completed-task")
    else
      $(this).parent().parent().removeClass("completed-task").addClass("task")
  $(".delete-task").click ->
    $(this).parent().parent().toggle()
  $(".menu-toggle").click ->
    if $(this).parent().children(".task-menu").css("display") == "none"
      $(".task-menu").hide()
      $(this).parent().children(".task-menu").toggle()
    else
      $(".task-menu").hide()
