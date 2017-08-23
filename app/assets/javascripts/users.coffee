# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('#user_picture').bind 'change', ->
  size_in_megabytes = this.files[0].size/1024/1024
  if size_in_megabytes > 3
    alert 'Maximum file size is 3MB. Please choose a smaller file.'
