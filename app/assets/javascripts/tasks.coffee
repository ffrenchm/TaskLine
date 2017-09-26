$(document).on 'turbolinks:load', ->
  $(".toggle-completed").click ->
    task = $(this).parent().children(".completed-task")
    if task.css("display") == "none"
      task.css("display" : "flex")
    else
      task.css("display" : "none")
  $(".toggle-more").click ->
    $(this).parent().children(".task-more").slideToggle(150)
  $("#task_repeat").click ->
    $(".every-field").slideToggle(150)
  $(".tickbox").hover ->
    $(this).toggleClass("tick-transition")
  $(".tickbox").click ->
    task = $(this).parent().parent()
    if task.hasClass("task")
      task.removeClass("task").addClass("completed-task")
      task.parent().children(".toggle-completed").removeClass("hide")
    else
      task.removeClass("completed-task").addClass("task")
  $(".delete-task").click ->
    $(this).parent().parent().parent().toggle()
  $(".menu-toggle").click ->
    if $(this).parent().children(".task-menu").css("display") == "none"
      $(".task-menu").hide()
      $(this).parent().children(".task-menu").toggle()
    else
      $(".task-menu").hide()
