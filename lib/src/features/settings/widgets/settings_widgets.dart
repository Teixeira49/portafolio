part of '../page/settings_modal.dart';

class _SettingsSectionRow extends StatelessWidget {
  const _SettingsSectionRow({
    required this.sectionTitle,
    required this.sectionRows,
  });

  final String sectionTitle;
  final List<Widget> sectionRows;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: WidthValues.padding,
    children: [
      Text("$sectionTitle:", style: ExtendedTextTheme.textMedium(context)),
      Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Wrap(
            spacing: WidthValues.spacingSm,
            runSpacing: WidthValues.spacingSm,
            alignment: WrapAlignment.end,
            children: sectionRows,
          ),
        ),
      ),
    ],
  );
}

class _SettingsIAModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    context.l10n.homePageIAModelLayer,
    style: ExtendedTextTheme.titleMedium(context),
  );
}
