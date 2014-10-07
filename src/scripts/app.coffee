sketch = require './sketch'
sketch.init()
sketch.animate()




isValidEmail = (email)->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return re.test(email)
complete = ->
  $("#cuboid form").removeClass("loading").addClass "complete"
  return
error = ->
  $("#cuboid form").removeClass("loading").addClass "error ready"
  return
$("#email").focus ->
  $("#cuboid form").addClass "ready"
  return

$("#email").blur ->
  $("#cuboid form").removeClass "ready"  if $(this).val() is ""
  return

$("#email").keyup ->
  email = $(this).val()
  if(email.length == 0)
    $(this).closest('form').removeClass("valid invalid")
  else if(isValidEmail(email))
    $(this).closest('form').addClass("valid").removeClass("invalid")
  else 
    $(this).closest('form').removeClass("valid").addClass("invalid")

  return

$("#cuboid form").submit ->
  $form = $(this)
  if !$form.hasClass('valid')
    return false
  $form.removeClass("ready").addClass "loading"
  $.ajax
    type: $form.attr("method")
    url: $form.attr("action")
    data: $form.serialize()
    cache: false
    dataType: "json"
    contentType: "application/json; charset=utf-8"
    error: (err) ->
      error()
      return
    success: (data) ->
      console.log(data)
      if data.result is "success"
        complete()
      else
        error()
      return

  return false

$(".reset-icon").click ->
  $("#cuboid form").removeClass "complete"
  return






((i, s, o, g, r, a, m) ->
  i["GoogleAnalyticsObject"] = r
  i[r] = i[r] or ->
    (i[r].q = i[r].q or []).push arguments
    return

  i[r].l = 1 * new Date()
  a = s.createElement(o)
  m = s.getElementsByTagName(o)[0]
  a.async = 1
  a.src = g
  m.parentNode.insertBefore a, m
  return
) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
ga "create", "UA-55513833-1", "auto"
ga "send", "pageview"