import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/asset_images.dart';
import '../../../core/variables/values/values.dart';
import '../../domain/entities/enums/enums.dart';

class SkillsCard extends StatelessWidget {
  const SkillsCard({
    super.key,
    required this.title,
    this.asset,
    required this.level,
    this.color,
  });

  final String title;
  final String? asset;
  final SkillLevel level;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
      color: ColorValues.bgSecondary(context),
    ),
    padding: EdgeInsets.all(WidthValues.padding),
    child: Row(
      spacing: WidthValues.spacingMd,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child:
              asset != null
                  ? SvgPicture.asset(
                    asset!,
                    width: 50,
                    height: 50,
                    colorFilter:
                        color != null
                            ? AppTheme.theme(context, null).brightness ==
                                    Brightness.dark
                                ? ColorFilter.mode(color!, BlendMode.srcIn)
                                : null
                            : null,
                  )
                  : Image.asset(AssetImages.emptyImage, width: 50, height: 50),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: ExtendedTextTheme.titleMedium(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${context.l10n.skillsPageLevelLabel}: ${level.levelTitle(context)}",
                style: ExtendedTextTheme.textMedium(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
