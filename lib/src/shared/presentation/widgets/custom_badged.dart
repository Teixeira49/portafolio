import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';

import '../../../core/theme/extended_text_theme.dart';
import '../../../core/variables/values/values.dart';

class CustomTitleBadged extends StatelessWidget {
  const CustomTitleBadged({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(WidthValues.radiusSm),
      color: ColorValues.bgBrandPrimary(context),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: WidthValues.spacingSm,
      vertical: WidthValues.spacingXxs,
    ),
    child: Text(
      selectChatName(context, name),
      style: ExtendedTextTheme.titleSmall(context),
    ),
  );

  String selectChatName(BuildContext context, String name) {
    switch (name) {
      case 'home_chat':
        return context.l10n.dashboardHomeButton;
      case 'about_chat':
        return context.l10n.dashboardAboutMeButton;
      case 'skills_chat':
        return context.l10n.dashboardSkillsButton;
      case 'projects_chat':
        return context.l10n.dashboardProjectsButton;
      case 'experience_chat':
        return context.l10n.dashboardExperienceButton;
      case 'education_chat':
        return context.l10n.dashboardEducationButton;
      default:
        return context.l10n.dashboardHomeButton;
    }
  }
}
