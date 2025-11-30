import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';
import 'package:portafolio/src/core/variables/constants/constants.dart';
import 'package:portafolio/src/core/variables/values/values.dart';
import 'package:timelines_plus/timelines_plus.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.experience});

  final List<Map<String, dynamic>> experience;

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0.025,
        color: ColorValues.fgBrandPrimary(context),
      ),
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.basic,
        indicatorStyle: IndicatorStyle.outlined,
        contentsBuilder:
            (context, index) => _TimelineElement(experience: experience[index]),
        itemCount: experience.length,
      ),
    );
  }
}

class _TimelineElement extends StatelessWidget {
  const _TimelineElement({required this.experience});

  final Map<String, dynamic> experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: WidthValues.spacingXs),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: WidthValues.spacingXs,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              spacing: WidthValues.spacingXs,
              runSpacing: WidthValues.spacingXs,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  experience['experience'],
                  style: ExtendedTextTheme.titleMedium(context),
                ),
                _TextDate(
                  init: experience['init_time'],
                  end: experience['end_time'],
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              experience['description'],
              style: ExtendedTextTheme.textSmall(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextDate extends StatelessWidget {
  const _TextDate({required this.init, required this.end});

  final String init;
  final String? end;

  @override
  Widget build(BuildContext context) {
    if (end == null) {
      return Text(
        init,
        style: TextStyle(color: ColorValues.textTertiary(context)),
      );
    } else if (end == StringConstants.emptyString) {
      return Text(
        "$init - ${context.l10n.projectActualDateLabel}",
        style: TextStyle(color: ColorValues.textTertiary(context)),
      );
    } else {
      return Text(
        "$init - $end",
        style: TextStyle(color: ColorValues.textTertiary(context)),
      );
    }
  }
}
