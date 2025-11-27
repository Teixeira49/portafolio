import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String appName = 'Portafolio Ing. Teixeira';

  static const double defaultBottomNavigationBarIconSize = 25;

  static const int pageLimit = 25;

  static const String developerName = 'Ing. Javier Teixeira';

  static final String githubAccount = dotenv.env['GITHUB_ACCOUNT'] ?? '';

  static final String linkedinAccount = dotenv.env['LINKEDIN_ACCOUNT'] ?? '';

  static final String gmailAccount = dotenv.env['GMAIL_ACCOUNT'] ?? '';

  static final String mainPhoneNumber = dotenv.env['MAIN_PHONE'] ?? '';

  static final String secondPhoneNumber = dotenv.env['SECOND_PHONE'] ?? '';

  static final String resume = dotenv.env['CV'] ?? '';

  static final String campusLocation = dotenv.env['UNIMET_LOCATION'] ?? '';

  static final String campusWebsite = dotenv.env['UNIMET_WEBSITE'] ?? '';
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
