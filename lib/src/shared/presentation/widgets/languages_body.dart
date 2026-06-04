import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';

import '../../../core/variables/values/values.dart';

// Mirrors .lang-cards: repeat(auto-fit, minmax(230px, 1fr)), gap: 12px
const double _kGap = 12;

int _columns(double width) {
  if (width < 500) return 1;
  return 2;
}

class LanguagesBody extends StatelessWidget {
  const LanguagesBody({super.key, required this.languages});

  final List<dynamic> languages;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _columns(constraints.maxWidth);
        final cardWidth =
            (constraints.maxWidth - (cols - 1) * _kGap) / cols;

        return Wrap(
          spacing: _kGap,
          runSpacing: _kGap,
          children: languages.map((lang) {
            return SizedBox(
              width: cardWidth,
              child: _LanguageCard(
                name: lang['name'] as String,
                flag: lang['flag'] as String,
                levelKey: lang['level'] as String,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Language card  (.lang-card)
// Surface glassmorphism + flag emoji + name + proficiency label
// ─────────────────────────────────────────────────────────────────────────────

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.name,
    required this.flag,
    required this.levelKey,
  });

  final String name;
  final String flag;
  final String levelKey; // "native" | "intermediate"

  String _levelLabel(BuildContext context) => switch (levelKey) {
        'native'       => context.l10n.languageNativeLabel,
        'intermediate' => context.l10n.languageIntermediateLabel,
        _              => levelKey,
      };

  // Maps level key → (active bars, accent color) — same palette as skills_card
  static const _kGreen = Color(0xFF00E660);
  static const _kBlue  = Color(0xFF5B8EF0);

  ({int active, Color color}) get _levelConfig => switch (levelKey) {
        'native'       => (active: 3, color: _kGreen),
        'intermediate' => (active: 2, color: _kBlue),
        _              => (active: 1, color: _kBlue),
      };

  @override
  Widget build(BuildContext context) {
    final cfg = _levelConfig;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ColorValues.bgSurface(context),
        border: Border.all(color: ColorValues.borderSurface(context)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // .lang-flag — emoji at 26 px
          Text(flag, style: const TextStyle(fontSize: 26, height: 1)),
          const Gap(14),
          // .lang-meta
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // .lang-name
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorValues.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 1),
                // .lang-sub
                Text(
                  _levelLabel(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: ColorValues.textTertiary(context),
                  ),
                ),
              ],
            ),
          ),
          const Gap(14),
          // Level bars — same design as .lvl-bars in skill cards
          _LangLvlBars(
            active: cfg.active,
            accent: cfg.color,
            dim: ColorValues.bgChipHover(context),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Level bars for language cards (3 segments, same style as skill cards)
// ─────────────────────────────────────────────────────────────────────────────

class _LangLvlBars extends StatelessWidget {
  const _LangLvlBars({
    required this.active,
    required this.accent,
    required this.dim,
  });

  final int active;
  final Color accent;
  final Color dim;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Container(
          width: 15,
          height: 4,
          margin: i < 2 ? const EdgeInsets.only(bottom: 3) : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: i >= (3 - active) ? accent : dim,
          ),
        );
      }),
    );
  }
}
