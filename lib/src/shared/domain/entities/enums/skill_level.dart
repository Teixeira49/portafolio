import 'package:flutter/cupertino.dart';
import 'package:portafolio/l10n/l10n.dart';

enum SkillLevel {
  low,
  medium,
  high;

  String levelTitle(BuildContext context) {
    switch(this) {
      case SkillLevel.low:
        return context.l10n.skillsPageLowLevelLabel;
      case SkillLevel.medium:
        return context.l10n.skillsPageMediumLevelLabel;
      case SkillLevel.high:
        return context.l10n.skillsPageHighLevelLabel;
    }
  }
}