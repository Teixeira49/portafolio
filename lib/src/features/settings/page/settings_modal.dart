import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';

import 'package:provider/provider.dart' show Consumer;

import '../../../core/providers/providers.dart';
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
                Icon(Icons.verified_user_outlined),
              ],
            ),
            _SettingsSectionRow(
              sectionTitle: context.l10n.settingsPageThemeLabel,
              sectionRows: [
                _ThemeOptionButton(
                  Icons.light_mode,
                  context.l10n.themeLightLabel,
                ),
                _ThemeOptionButton(
                  Icons.dark_mode,
                  context.l10n.themeDarkLabel,
                ),
                _ThemeOptionButton(
                  Icons.settings,
                  context.l10n.themeSystemLabel,
                ),
              ],
            ),
            _SettingsSectionRow(
              sectionTitle: context.l10n.settingsPageLanguageLabel,
              sectionRows: [
                _LanguageButton(
                  // La clave de traducción para 'Automático (Sistema)'
                  label: context.l10n.languageSystemLabel,
                  // El locale para esta opción es null
                  locale: null,
                  currentLocale: appProvider.locale,
                  onTap: () {
                    // Llama a setLocale con null para resetear al idioma del sistema
                    getIt<AppProvider>().setLocale(null);
                  },
                ),
                // Opción para Inglés
                _LanguageButton(
                  label: context.l10n.languageEnglishLabel,
                  locale: const Locale('en'),
                  currentLocale: appProvider.locale,
                  onTap: () {
                    getIt<AppProvider>().setLocale(const Locale('en'));
                  },
                ),

                // Opción para Español
                _LanguageButton(
                  label: context.l10n.languageSpanishLabel,
                  locale: const Locale('es'),
                  currentLocale: appProvider.locale,
                  onTap: () {
                    getIt<AppProvider>().setLocale(const Locale('es'));
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.closeButtonLabel), // "Close"
              ),
            ),
          ],
        ),
  );
}
