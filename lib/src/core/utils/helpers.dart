import 'package:flutter/material.dart';

import '../variables/variables.dart';

class Helpers {
  static String sendMeEmail() {
    return 'mailto:${Constants.gmailAccount}';
  }

  static String whatsMee({
    required BuildContext context,
    required String number,
  }) {
    final languageCode = Localizations.localeOf(context).languageCode;
    String message;
    switch (languageCode) {
      case 'es':
        message = 'Hola, vi tu portafolio y me gustaría contactarte.';
        break;
      case 'en':
      default:
        message =
            'Hello, I saw your portfolio and I would like to contact you.';
        break;
    }
    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$number?text=$encodedMessage';
  }
}
