import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';

import 'package:provider/provider.dart' show Consumer;

import '../../../core/providers/providers.dart';
import '../../../core/utils/asset_icons.dart';
import '../../../core/variables/values/values.dart';
import '../../../shared/presentation/modal/custom_modal.dart';

part '../widgets/settings_buttons.dart';

part '../widgets/settings_widgets.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) => Consumer<AppProvider>(
    builder:
        (context, appProvider, child) => CustomModal(
          title: context.l10n.settingsPageLabel,
          children: [
            _SettingsSectionRow(
              sectionTitle: context.l10n.settingsPageIAModelLabel,
              sectionRows: [
                _SettingsIAModel(),
                SvgPicture.asset(
                  AssetIcons.iconBot,
                  fit: BoxFit.contain,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    ColorValues.borderSolid(context),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const Divider(),
            _SettingsSectionRow(
              sectionTitle: context.l10n.settingsPageThemeLabel,
              sectionRows: [
                _ThemeOptionButton(
                  icon: Icons.light_mode,
                  currentTheme: appProvider.themeMode,
                  myTheme: ThemeMode.light,
                  label: context.l10n.themeLightLabel,
                  selectedColor: ColorValues.brandGreenSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setThemeMode(ThemeMode.light);
                  },
                ),
                _ThemeOptionButton(
                  icon: Icons.dark_mode,
                  currentTheme: appProvider.themeMode,
                  myTheme: ThemeMode.dark,
                  label: context.l10n.themeDarkLabel,
                  selectedColor: ColorValues.brandBlueSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setThemeMode(ThemeMode.dark);
                  },
                ),
                _ThemeOptionButton(
                  icon: Icons.settings,
                  currentTheme: appProvider.themeMode,
                  myTheme: ThemeMode.system,
                  label: context.l10n.themeSystemLabel,
                  selectedColor: ColorValues.brandRedSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setThemeMode(ThemeMode.system);
                  },
                ),
              ],
            ),
            const Divider(),
            _SettingsSectionRow(
              sectionTitle: context.l10n.settingsPageLanguageLabel,
              sectionRows: [
                _LanguageButton(
                  label: context.l10n.languageSystemLabel,
                  locale: null,
                  currentLocale: appProvider.locale,
                  selectedColor: ColorValues.brandGreenSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setLocale(null);
                  },
                ),
                _LanguageButton(
                  label: context.l10n.languageEnglishLabel,
                  locale: const Locale('en'),
                  currentLocale: appProvider.locale,
                  selectedColor: ColorValues.brandBlueSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setLocale(const Locale('en'));
                  },
                ),
                _LanguageButton(
                  label: context.l10n.languageSpanishLabel,
                  locale: const Locale('es'),
                  currentLocale: appProvider.locale,
                  selectedColor: ColorValues.brandRedSolid(context),
                  onTap: () {
                    getIt<AppProvider>().setLocale(const Locale('es'));
                  },
                ),
              ],
            ),
          ],
        ),
  );
}
