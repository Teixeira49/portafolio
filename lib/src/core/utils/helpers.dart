import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';

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

  static String getMonthName(
    BuildContext context,
    int monthNumber, {
    bool short = false,
  }) {
    switch (monthNumber) {
      case 1:
        return getShort(context.l10n.dateJanuaryLabel, short: short);
      case 2:
        return getShort(context.l10n.dateFebruaryLabel, short: short);
      case 3:
        return getShort(context.l10n.dateMarchLabel, short: short);
      case 4:
        return getShort(context.l10n.dateAprilLabel, short: short);
      case 5:
        return getShort(context.l10n.dateMayLabel, short: short);
      case 6:
        return getShort(context.l10n.dateJuneLabel, short: short);
      case 7:
        return getShort(context.l10n.dateJulyLabel, short: short);
      case 8:
        return getShort(context.l10n.dateAugustLabel, short: short);
      case 9:
        return getShort(context.l10n.dateSeptemberLabel, short: short);
      case 10:
        return getShort(context.l10n.dateOctoberLabel, short: short);
      case 11:
        return getShort(context.l10n.dateNovemberLabel, short: short);
      case 12:
        return getShort(context.l10n.dateDecemberLabel, short: short);
      default:
        return '';
    }
  }

  static String getShort(String text, {bool short = false}) =>
      !short ? text : text.substring(0, 3);

  static String getParsedDate(
    BuildContext context,
    String date, {
    bool shortMonth = false,
    bool shortYear = false,
  }) {
    return "${getMonthName(context, int.parse(date.split('/')[0]), short: shortMonth)} ${getShort(date.split('/')[1], short: shortYear)}";
  }
}
