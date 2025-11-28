class Constants {
  static const String appName = 'Portafolio Ing. Teixeira';

  static const double defaultBottomNavigationBarIconSize = 25;

  static const int pageLimit = 25;

  static const String developerName = 'Ing. Javier Teixeira';

  static const String githubAccount = String.fromEnvironment(
    'GITHUB',
    defaultValue: StringConstants.emptyString,
  );

  static const String linkedinAccount = String.fromEnvironment(
    'LINKEDIN',
    defaultValue: StringConstants.emptyString,
  );

  static const String gmailAccount = String.fromEnvironment(
    'GMAIL',
    defaultValue: StringConstants.emptyString,
  );

  static const String mainPhoneNumber = String.fromEnvironment(
    'MAIN_PHONE',
    defaultValue: StringConstants.emptyString,
  );

  //static const String secondPhoneNumber = String.fromEnvironment('SECOND_PHONE',
  //  defaultValue: StringConstants.emptyString,
  //);

  static const String resume = String.fromEnvironment(
    'CV',
    defaultValue: StringConstants.emptyString,
  );

  static const String campusLocation =
      'https://www.google.co.ve/maps/place/Universidad+Metropolitana/@10.5001559,-66.7871024,17z/data=!3m1!4b1!4m6!3m5!1s0x8c2a576d54142307:0x346aa4e5e126367e!8m2!3d10.5001506!4d-66.7845275!16s%2Fm%2F0277j73?hl=es-419&entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D';

  static final String campusWebsite = 'https://www.unimet.edu.ve/';

  static const String location = String.fromEnvironment(
    'LOC',
    defaultValue: StringConstants.emptyString,
  );

  static const String locationLink = String.fromEnvironment('LOC_LINK',
    defaultValue: StringConstants.emptyString,
  );
}

class HttpConstants {
  static const String bearer = 'Bearer';

  static const String tokenHeader = 'Authorization';

  static const String contentTypeHeader = 'Content-Type';

  static const String applicationJson = 'application/json';

  static const String applicationXWwwFormUrlencoded =
      'application/x-www-form-urlencoded';
}

class StringConstants {
  static const String whatsApp = "Whats App";

  static const String linkedin = "Linkedin";

  static const String gmail = "Gmail";

  static const String voidRow = '--';

  static const String emptyString = '';

  static const String emptySpace = ' ';
}
