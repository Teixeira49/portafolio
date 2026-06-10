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
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: getIt<AppProvider>(),
    builder: (context, _) {
      final current = getIt<AppProvider>().selectedModel;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModelOptionButton(
            label: 'Flash',
            model: AppModel.flash,
            currentModel: current,
          ),
          SizedBox(width: WidthValues.spacingXs),
          _ModelOptionButton(
            label: 'Pro',
            model: AppModel.pro,
            currentModel: current,
          ),
        ],
      );
    },
  );
}

class _ModelOptionButton extends StatelessWidget {
  const _ModelOptionButton({
    required this.label,
    required this.model,
    required this.currentModel,
  });

  final String label;
  final AppModel model;
  final AppModel currentModel;

  @override
  Widget build(BuildContext context) {
    final isSelected = model == currentModel;

    return OutlinedButton(
      onPressed: () => getIt<AppProvider>().setModel(model),
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor.withAlpha(40) : null,
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
            : null,
        foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        overlayColor: Theme.of(context).primaryColor.withAlpha(30),
      ),
      child: Text(
        label,
        style: ExtendedTextTheme.textSmall(context),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
