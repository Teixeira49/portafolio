part of '../page/settings_modal.dart';

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.locale,
    required this.currentLocale,
    required this.onTap,
  });

  final String label;
  final Locale? locale;
  final Locale? currentLocale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = locale == currentLocale;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor.withAlpha(40) : null,
        side:
            isSelected
                ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
                : null,
        // Add hover effect color
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

class _ThemeOptionButton extends StatelessWidget {
  const _ThemeOptionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.currentTheme,
    required this.myTheme,
  });

  final IconData icon;
  final String label;
  final ThemeMode currentTheme;
  final ThemeMode myTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          currentTheme == myTheme
              ? Theme.of(context).primaryColor.withAlpha(40)
              : ColorValues.utilityGray200(context),
      borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
        hoverColor: ColorValues.bgBrandPrimary(context),
        hoverDuration: const Duration(milliseconds: 250),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: WidthValues.padding,
            vertical: WidthValues.spacingSm,
          ),
          width: 120,
          child: Column(
            spacing: WidthValues.spacingXs,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: WidthValues.spacingXl),
              Text(
                label,
                style: ExtendedTextTheme.textSmall(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
