part of '../page/settings_modal.dart';

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.locale,
    required this.currentLocale,
    required this.onTap,
    required this.selectedColor,
  });

  final String label;
  final Locale? locale;
  final Locale? currentLocale;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final isSelected = locale == currentLocale;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? selectedColor.withAlpha(40) : null,
        side: isSelected
            ? BorderSide(color: selectedColor, width: 1)
            : null,
        foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        overlayColor: selectedColor.withAlpha(30),
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
    required this.selectedColor,
  });

  final IconData icon;
  final String label;
  final ThemeMode currentTheme;
  final ThemeMode myTheme;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentTheme == myTheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
        hoverColor: ColorValues.bgBrandPrimary(context),
        hoverDuration: const Duration(milliseconds: 250),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: WidthValues.padding,
            vertical: WidthValues.spacingSm,
          ),
          width: 120,
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withAlpha(40)
                : (Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : ColorValues.utilityGray200(context)),
            borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
            border: Border.all(
              color: isSelected ? selectedColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            spacing: WidthValues.spacingXs,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: WidthValues.spacingXl,
                color: selectedColor,
              ),
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
