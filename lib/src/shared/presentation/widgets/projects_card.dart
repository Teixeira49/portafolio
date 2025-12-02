import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/utils/asset_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/responsive.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/variables/variables.dart';
import 'dynamic_icon_button.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.name,
    required this.initDate,
    required this.endDate,
    required this.technologies,
    required this.repository,
    required this.link,
    required this.prototype,
    required this.description,
    required this.private,
  });

  final String name;
  final String initDate;
  final String endDate;
  final List<String> technologies;
  final List repository;
  final String? link;
  final Map<String, dynamic> description;
  final String? prototype;
  final bool private;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
      color: ColorValues.bgSecondary(context),
    ),
    padding: EdgeInsets.all(WidthValues.padding),
    child: Column(
      spacing: WidthValues.spacingSm,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: ExtendedTextTheme.titleMedium(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${Helpers.getParsedDate(context, initDate, shortMonth: Responsive.isMobile(context))} - ${Helpers.getParsedDate(context, endDate, shortMonth: Responsive.isMobile(context))}",
            style: ExtendedTextTheme.textSmall(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          selectLocale(
            Localizations.localeOf(context).languageCode,
            description,
          ),
          style: ExtendedTextTheme.textMedium(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Wrap(
                runSpacing: WidthValues.spacingXs,
                spacing: WidthValues.spacingXs,
                children:
                    technologies.map((technologies) {
                      return _TechnologyBadged(name: technologies);
                    }).toList(),
              ),
            ),
            if (prototype != null) ...[
              Padding(
                padding: EdgeInsets.only(right: WidthValues.spacingSm),
                child: DynamicIconButton(
                  asset: AssetIcons.iconFigma,
                  route: prototype!,
                ),
              ),
            ] else if (repository.isNotEmpty && !private) ...[
              DynamicIconPopMenu(
                asset: AssetIcons.iconGithubLight,
                options: repository,
                maskColor:
                    AppTheme.theme(context, null).brightness == Brightness.dark
                        ? ColorValues.fgPrimary(context).withAlpha(180)
                        : null,
              ),
            ] else ...[
              Tooltip(
                message: context.l10n.projectIsPrivateLabel,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: WidthValues.spacingXs,
                    top: WidthValues.spacingXs,
                  ),
                  child: DynamicIconButton(
                    asset: AssetIcons.iconLock,
                    route: null,
                    maskColor:
                        AppTheme.theme(context, null).brightness ==
                                Brightness.dark
                            ? ColorValues.fgPrimary(context).withAlpha(220)
                            : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );

  String selectLocale(String locale, Map<String, dynamic> message) {
    switch (locale) {
      case 'en':
        return message['en'].toString();
      case 'es':
        return message['es'].toString();
      default:
        return message['en'].toString();
    }
  }
}

class _TechnologyBadged extends StatelessWidget {
  const _TechnologyBadged({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(WidthValues.radiusSm),
      color: ColorValues.bgBrandPrimary(context),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: WidthValues.spacingXs,
      vertical: WidthValues.spacingXxs,
    ),
    child: Text(name, style: ExtendedTextTheme.textSmall(context)),
  );
}

//iconLock
