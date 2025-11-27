/*import 'package:arturospos/l10n/l10n.dart';
import 'package:arturospos/src/shared/domain/entities/enums/enums.dart';
import 'package:arturospos/src/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class StylesConstants {
  static ButtonStyle textButtonStyle(
    BuildContext context, {
    required bool isMainButton,
  }) {
    final brandColor = ColorValues.fgBrandPrimary(context);

    final whiteColor = ColorValues.fgWhite(context);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        isMainButton ? brandColor : whiteColor,
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidthValues.radiusXs),
          side: BorderSide(color: brandColor),
        ),
      ),
    );
  }

  static InputDecoration inputDecoration(
    BuildContext context,
    String? hintText, {
    TextStyle? hintStyle,
    bool isDense = true,
    bool border = true,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      border: border ? const OutlineInputBorder() : null,
      isDense: isDense,
      contentPadding: EdgeInsets.all(WidthValues.padding),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.fgBrandPrimary(context),
          width: 2,
        ),
      ),
    );
  }

  static ButtonStyle elevatedButtonDecoration(
    BuildContext context, {
    bool enabled = true,
  }) {
    return ElevatedButton.styleFrom(
      side: BorderSide(
        color: enabled ? ColorValues.fgBrandPrimary(
          context,
        )  : ColorValues.bgSecondary(
          context,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
    );
  }

  static TimelineThemeData timelineThemeData(BuildContext context) {
    return TimelineThemeData(
      nodePosition: 0,
      connectorTheme: ConnectorThemeData(
        thickness: 3,
        color: ColorValues.utilityGray200(context),
      ),
      indicatorTheme: const IndicatorThemeData(
        size: 15,
      ),
    );
  }

  static SolidLineConnector solidConnectorThemeData(
    BuildContext context,
    TimelineStatus status,
  ) {
    switch (status) {
      case TimelineStatus.done:
        return SolidLineConnector(
          color: ColorValues.tagGreenFg(context),
        );
      case TimelineStatus.sync:
        return SolidLineConnector(
          color: ColorValues.tagBlueFg(context),
        );
      case TimelineStatus.inProgress:
        return SolidLineConnector(
          color: ColorValues.tagYellowFg(context),
        );
      case TimelineStatus.todo:
        return SolidLineConnector(
          color: ColorValues.utilityGray400(context),
        );
      case TimelineStatus.error:
        return SolidLineConnector(
          color: ColorValues.tagRedFg(context),
        );
    }
  }

  static Indicator dotIndicatorThemeData(
    BuildContext context,
    TimelineStatus status,
  ) {
    switch (status) {
      case TimelineStatus.done:
        return DotIndicator(
          color: ColorValues.tagGreenFg(context),
          child: _buildIcon(
            context,
            status,
          ),
        );
      case TimelineStatus.sync:
        return DotIndicator(
          color: ColorValues.tagBlueSecondaryFg(context),
          child: _buildIcon(
            context,
            status,
          ),
        );
      case TimelineStatus.inProgress:
        return OutlinedDotIndicator(
          color: ColorValues.tagYellowFg(context),
          backgroundColor: ColorValues.tagYellowBg(context),
        );
      case TimelineStatus.todo:
        return OutlinedDotIndicator(
          color: ColorValues.utilityGray400(context),
          backgroundColor: ColorValues.utilityGray300(context),
        );
      case TimelineStatus.error:
        return OutlinedDotIndicator(
          color: ColorValues.tagRedFg(context),
          backgroundColor: ColorValues.tagRedFg(context),
          child: _buildIcon(
            context,
            status,
          ),
        );
    }
  }

  static Icon _buildIcon(BuildContext context, TimelineStatus status) {
    IconData icon;
    switch (status) {
      case TimelineStatus.done:
        icon = Icons.check;
      case TimelineStatus.sync:
        icon = Icons.sync;
      case TimelineStatus.error:
        icon = Icons.close;
      case TimelineStatus.inProgress:
        icon = Icons.access_time;
      case TimelineStatus.todo:
        icon = Icons.task_alt;
    }
    return Icon(
      icon,
      color: ColorValues.bgSecondary(context),
      size: 12,
    );
  }

  static List<TimelineStatus> getTimelineStatus(ActiveStatus status) {
    switch (status) {
      case == ActiveStatus.pending:
        return [
          TimelineStatus.todo,
          TimelineStatus.todo,
          TimelineStatus.todo,
          TimelineStatus.inProgress,
        ];
      case == ActiveStatus.accepted:
        return [
          TimelineStatus.todo,
          TimelineStatus.done,
          TimelineStatus.inProgress,
          TimelineStatus.done,
        ];
      case == ActiveStatus.send:
        return [
          TimelineStatus.todo,
          TimelineStatus.inProgress,
          TimelineStatus.done,
          TimelineStatus.done,
        ];
      case == ActiveStatus.received:
        return [
          TimelineStatus.done,
          TimelineStatus.done,
          TimelineStatus.done,
          TimelineStatus.done,
        ];
      case == ActiveStatus.rejected:
        return [
          TimelineStatus.error,
          TimelineStatus.error,
          TimelineStatus.error,
          TimelineStatus.error,
        ];
      default:
        return [
          TimelineStatus.sync,
          TimelineStatus.sync,
          TimelineStatus.sync,
          TimelineStatus.sync,
        ];
    }
  }

  static String getTimelineStatusName(
    BuildContext context,
    int index,
  ) {
    switch (index) {
      case == 3:
        return context.l10n.timelinePendingLabel;
      case == 2:
        return context.l10n.timelineAcceptedLabel;
      case == 1:
        return context.l10n.timelineSentLabel;
      case == 0:
        return context.l10n.timelineReceivedLabel;
      default:
        return context.l10n.timelineSyncLabel;
    }
  }
}
*/