args2Obj = ->
  keys = Array::slice.apply(arguments)
  ->
    values = Array::slice.apply(arguments)
    keys.reduce ((result, key, index) ->
      result[key] = values[index]
      result
    ), {}

group = args2Obj("name", "sponsors")
sponsor = args2Obj("name", "href", "image")

sponsorGroups = [
  group('giga',[
    sponsor('BasisBank','http://www.basisbank.ge/','http://www.basisbank.ge/imgs/logo_en.jpg')
  ]),
  group('mega',[
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
  ]),
  group('kilo',[
    sponsor('AzRy','http://www.azry.com/','http://www.azry.com/new/images/logo.png')
  ])
]

module.exports = 
  data:
    sponsorGroups: sponsorGroups
  defaultLanguageKey: 'en'
  locals:
    en:
      'META_SITE_URL': 'http://hacktbilisi.com'
      'META_TITLE': 'hackTbilisi'
      'META_SITE_NAME': 'hackTbilisi.com'
      'META_DESCRIPTION': 'Connecting Hackers from Europe and Asia, Tbilisi, Georgia , Dec 19-21 .uniHack',

      'Stay Tuned!': 'Stay Tuned!'
      'Your Email': 'Your Email'
      'Just a moment': 'Just a sec'
      'We\'ll be in touch!': 'We\'ll be in touch!'
      'Connecting Hackers from Europe and Asia': 'Connecting Hackers from Europe and Asia'
      'dec':'dec'
      'contact us':'contact us'
      'languagePrefix': 'en/'
      '%s on %s': '%s on %s'
    ka:
      'dec':'დეკ'
      'contact us':'დაგვიკავშირდით'
      'languagePrefix': ''
      '%s on %s': '%s %s-ზე'
      'Stay Tuned!': 'გამოიწერე!'
      'Your Email': 'თქვენი ელ-ფოსტა'
      'Just a moment': 'იტვირთება'
      'We\'ll be in touch!': 'დაგიკავშირდებით!'
