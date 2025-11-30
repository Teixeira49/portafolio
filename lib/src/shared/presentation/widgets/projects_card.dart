import 'package:flutter/material.dart';
import 'package:portafolio/src/core/utils/asset_icons.dart';

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
  final String description;
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
            "$initDate - $endDate",
            style: ExtendedTextTheme.textSmall(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(description, style: ExtendedTextTheme.textMedium(context)),
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
                  route: prototype!
                ),
              ),
            ] else if (repository.isNotEmpty && !private) ...[
              DynamicIconPopMenu(
                asset: AssetIcons.iconGithubLight,
                options: repository,
              ),
            ] else ...[
              Tooltip(
                message: 'This project is private',
                child: Padding(
                  padding: EdgeInsets.only(
                    right: WidthValues.spacingXs,
                    top: WidthValues.spacingXs,
                  ),
                  child: DynamicIconButton(
                    asset: AssetIcons.iconLock,
                    route: null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );
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
