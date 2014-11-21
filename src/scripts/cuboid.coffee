isValidEmail = (email)->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return re.test(email)

module.exports = ($form,useAjax)->
  complete = ->
    $form.removeClass("loading").addClass "complete"
    return
  error = ->
    $form.removeClass("loading").addClass "error ready"
    return
  
  $form.find("#email").focus ->
    $form.addClass "ready"
    return

  $form.find("#email").blur ->
    $form.removeClass "ready"  if $(this).val() is ""
    return

  $form.find("#email").keyup ->
    email = $(this).val()
    if(email.length == 0)
      $(this).closest('form').removeClass("valid invalid")
    else if(isValidEmail(email))
      $(this).closest('form').addClass("valid").removeClass("invalid")
    else 
      $(this).closest('form').removeClass("valid").addClass("invalid")
    return

  $form.find(".reset-icon").click ->
    $form.removeClass "complete"
    return


  $form.submit ->
    return false if !$form.hasClass('valid')
    return true if not useAjax
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


