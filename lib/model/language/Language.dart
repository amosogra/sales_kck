

class Language {

  // country code ( IT , AF ... )
  String? code;

  // locale (en, es, da .. )
  String? locale;

  // full language ( English, Danish ... )
  String? language;

  // map of keys used based on industry type ( service worker, route etc ..)
  Map<String, String>? dictionary;

  Language({this.code, this.locale, this.language, this.dictionary});

}