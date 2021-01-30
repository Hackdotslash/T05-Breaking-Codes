class Language{
  String name;
  String code;

  Language({this.code, this.name});

  static List<Language> getLanguages(){
    return [
      Language(code: 'en', name: 'English'),
      Language(code: 'gu', name: 'Gujarati'),
      Language(code: 'hi', name: 'Hindi')
    ];
  }
}