class LocalesLanguage {
  List get supportedLanguages => [
        {
          'code': 'en',
          'name': 'English',
          'countryCode': 'US',
        },
        {
          'code': 'th',
          'name': 'ไทย',
          'countryCode': 'TH',
        },
        {
          'code': 'la',
          'name': 'ລາວ',
          'countryCode': 'LA',
        }
      ];

  String getLanguageName(String code) {
    return supportedLanguages.firstWhere((lang) => lang['code'] == code)['name'];
  }

  String getCountryCode(String code) {
    return supportedLanguages.firstWhere((lang) => lang['code'] == code)['countryCode'];
  }

  String getLanguageCode(String name) {
    return supportedLanguages.firstWhere((lang) => lang['name'] == name)['code'];
  }

  List<Map<String, dynamic>> get allGet {
    return supportedLanguages.map((lang) {
      return {
        'code': lang['code']!,
        'name': lang['name']!,
        'countryCode': lang['countryCode']!,
      };
    }).toList();
  }
}
