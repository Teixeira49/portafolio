import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';

import '../../../core/variables/values/values.dart';

/// Section breadcrumb label shown in the chat top bar.
/// Matches the design's `.crumb` element:
///   font-size: 14.5px · font-weight: 600 · color: --txt-mute
class CustomTitleBadged extends StatelessWidget {
  const CustomTitleBadged({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      _label(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        color: ColorValues.textTertiary(context),
      ),
    );
  }

  String _label(BuildContext context) {
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
