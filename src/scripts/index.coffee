sketch = require './sketch'
sketch.init()
sketch.animate()

onscroller = require './onscroller'
elements = document.getElementsByClassName('page')
onVisabilityChangeListener = require('./onVisabilityChange')(
  onscroller.push.bind(onscroller),
  elements,
  /page-([a-zA-Z0-9\-]+)/g
)
onActiveElementChangeListener = require('./onActiveElementChange')(
  onscroller.push.bind(onscroller),
  elements
)

onActiveElementChangeListener.listen (elementId)->  
  document.body.className = document.body.className.replace(/active-([a-zA-Z0-9\-]+)/g,'')
  document.body.classList.add("active-#{elementId}")
  return

addVisabilityClassToElement = (page)->
  element = document.body
  return (isVisable)->
    if isVisable
      element.classList.add("#{page}-visable")
    else
      element.classList.remove("#{page}-visable")  

Array::map.call elements, (el) -> 
  onVisabilityChangeListener.listen el.id, addVisabilityClassToElement(el.id)
  



require('./cuboid')($("#cuboid form"),false)
require('./analytics')("UA-55513833-1")



$ ->
  $("a[href*=#]:not([href=#])").click ->
    if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
      target = $(@hash)
      target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
      if target.length
        $("html,body").animate
          scrollTop: target.offset().top
        , 1000
        false

  return