args2Obj = ->
  keys = Array::slice.apply(arguments)
  ->
    values = Array::slice.apply(arguments)
    keys.reduce ((result, key, index) ->
      result[key] = values[index]
      result
    ), {}

group = args2Obj("name", "sponsors")
sponsor = partner = args2Obj("name", "href", "image")
language = args2Obj("url", "title")


sponsorGroups = [
  group('giga',[
    sponsor('BasisBank','http://www.basisbank.ge/','/images/sponsors/basisbank.png')
  ]),
  group('mega',[
    sponsor("Alta Software", "http://altasoft.ge", "/images/sponsors/altasoft.png")
    sponsor("GAU", "http://gau.edu.ge/", "/images/sponsors/gau.jpg")
    sponsor("APEX", "http://apex.ge", "/images/sponsors/apex.png")
    sponsor("Mobility", "http://mobility.ge", "/images/sponsors/mobility.png")
  ]),
  group('kilo',[
    sponsor("B.A.G", "http://bag.ge", "/images/sponsors/bag.png")
    sponsor("AZRY", "http://azry.com", "/images/sponsors/azri.png")
  ])
]


mediaPartners = [
  partner('ideahub',"http://ideahub.ge","/images/sponsors/idea.png")
  partner('Marketer',"http://marketer.ge","/images/sponsors/marketer.png")
  partner('tabula',"http://tabula.ge","/images/sponsors/tabula.png")
]
partners = [
  partner('GitHub','http://github.com','/images/sponsors/github.png')
]

module.exports = 
  data:
    sponsorGroups: sponsorGroups
    mediaPartners: mediaPartners
    partners: partners
  defaultLanguageKey: 'en'
  locals:
    en:
      'META_SITE_URL': 'http://hacktbilisi.com'
      'META_TITLE': 'hackTBILISI'
      'META_SITE_NAME': 'hackTbilisi.com'
      'META_DESCRIPTION': 'Uniting Hackers from Europe and Asia, Tbilisi, Georgia , Dec 19-21 .uniHack',

      'Stay Tuned!': 'Stay Tuned!'
      'Your Email': 'Your Email'
      'Just a moment': 'Just a sec'
      'We\'ll be in touch!': 'We\'ll be in touch!'
      'dec':'dec'
      'contact us':'contact us'
      'nextLanguage': language('/','GEO')
      'languagePrefix': 'en/'
      '%s on %s': '%s on %s'
      'Register': 'Register'
      'კითხვები': 'F.A.Q'
      'პარტნიორები': 'Partners'
      'მედია პარტნიორები': 'Media Partners'
      'სპონსორები': 'Sponsors'
      'Free university of Tbilisi': 'Free university of Tbilisi'
    ka:
      'Free university of Tbilisi': 'თავისუფალი უნივერსიტეტი'
      'პარტნიორები': 'პარტნიორები'
      'მედია პარტნიორები': 'მედია პარტნიორები'
      'სპონსორები': 'სპონსორები'
      'კითხვები': 'კითხვები'
      'Register': 'რეგისტრაცია'
      'dec':'დეკ'
      'contact us':'დაგვიკავშირდით'
      'nextLanguage': language('/en','ENG')
      'languagePrefix': '/'
      '%s on %s': '%s %s-ზე'
      'Stay Tuned!': 'გამოიწერე!'
      'Your Email': 'თქვენი ელ-ფოსტა'
      'Just a moment': 'იტვირთება'
      'We\'ll be in touch!': 'დაგიკავშირდებით!'
