import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/variables/values/values.dart';
import '../../data/datasource/local/skill_detail_data.dart';
import '../../domain/entities/enums/skill_level.dart';

// Level accent colors — same as skills_card.dart
const _kColorHigh   = Color(0xFF00E660);
const _kColorMedium = Color(0xFF5B8EF0);
const _kColorLow    = Color(0xFFFF5A5A);

Color _levelColor(SkillLevel level) => switch (level) {
      SkillLevel.high   => _kColorHigh,
      SkillLevel.medium => _kColorMedium,
      SkillLevel.low    => _kColorLow,
    };

/// Opens the tech-detail dialog for [skillName].
/// Silently does nothing if [skillName] has no entry in [skillDetailData].
void showSkillDetailModal({
  required BuildContext context,
  required String skillName,
  required SkillLevel level,
  String? assetPath,
  Color? accentColor,
}) {
  final key = normalizeKey(skillName);
  final detail = skillDetailData[key];
  if (detail == null) return;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: const Color(0x8C000000),
    transitionDuration: const Duration(milliseconds: 240),
    transitionBuilder: (ctx, anim, _, child) {
      final curved = CurvedAnimation(
        parent: anim,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(curved),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.025),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        ),
      );
    },
    pageBuilder: (ctx, _, __) => _SkillDetailModal(
      skillName: skillName,
      detail: detail,
      level: level,
      assetPath: assetPath,
      accentColor: accentColor ?? detail.accentColor,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Modal widget (.tm-card)
// ─────────────────────────────────────────────────────────────────────────────

class _SkillDetailModal extends StatelessWidget {
  const _SkillDetailModal({
    required this.skillName,
    required this.detail,
    required this.level,
    this.assetPath,
    required this.accentColor,
  });

  final String skillName;
  final SkillDetail detail;
  final SkillLevel level;
  final String? assetPath;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final isEs = Localizations.localeOf(context).languageCode == 'es';
    final desc = detail.desc(isEs);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.fromLTRB(28, 26, 28, 28),
              decoration: BoxDecoration(
                color: ColorValues.bgSecondary(context),
                border: Border.all(color: ColorValues.borderLine(context)),
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xB2000000),
                    blurRadius: 90,
                    spreadRadius: -20,
                    offset: Offset(0, 30),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // .tm-head ─────────────────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // .tm-ico — 54×54 white container with SVG icon
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: ColorValues.borderSurface(context),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        child: assetPath != null
                            ? SvgPicture.asset(
                                assetPath!,
                                width: 34,
                                height: 34,
                                fit: BoxFit.contain,
                              )
                            : _IconMonogram(
                                name: skillName,
                                color: accentColor,
                              ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // .tm-title
                            Text(
                              skillName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: ColorValues.textPrimary(context),
                              ),
                            ),
                            const SizedBox(height: 2),
                            // .tm-cat
                            Text(
                              detail.category(isEs),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorValues.textTertiary(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Close button
                      _CloseBtn(),
                    ],
                  ),

                  // .tm-desc ──────────────────────────────────────────────────
                  if (desc.isNotEmpty) ...[
                    const Gap(16),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.55,
                        color: ColorValues.textSecondary(context),
                      ),
                    ),
                  ],

                  // Nivel ─────────────────────────────────────────────────────
                  const Gap(18),
                  _SectionLabel(
                    isEs
                        ? 'Nivel de dominio'
                        : 'Proficiency level',
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      _LevelBar(level: level),
                      const Gap(10),
                      Text(
                        level.levelTitle(context),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _levelColor(level),
                        ),
                      ),
                    ],
                  ),

                  // .tm-uses ──────────────────────────────────────────────────
                  if (detail.uses.isNotEmpty) ...[
                    const Gap(18),
                    _SectionLabel(
                      isEs
                          ? 'Usos en los que trabajo'
                          : 'Areas I work with',
                    ),
                    const Gap(10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detail.uses.map((u) => _UseChip(u)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Section title label — 12px / 700 / uppercase / textTertiary
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: ColorValues.textTertiary(context),
    ),
  );
}

/// Use chip (.tm-use)
class _UseChip extends StatelessWidget {
  const _UseChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: ColorValues.bgChip(context),
      border: Border.all(color: ColorValues.borderChip(context)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: ColorValues.textSecondary(context),
      ),
    ),
  );
}

/// Level bar row — 5 segments to show precise level within the 3-tier system
class _LevelBar extends StatelessWidget {
  const _LevelBar({required this.level});
  final SkillLevel level;

  @override
  Widget build(BuildContext context) {
    final int active = switch (level) {
      SkillLevel.low    => 1,
      SkillLevel.medium => 3,
      SkillLevel.high   => 5,
    };
    final color = _levelColor(level);
    final dim   = ColorValues.bgChipHover(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) => Container(
        width: 20,
        height: 5,
        margin: i < 4 ? const EdgeInsets.only(right: 4) : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: i < active ? color : dim,
        ),
      )),
    );
  }
}

/// Monogram fallback when no SVG is available
class _IconMonogram extends StatelessWidget {
  const _IconMonogram({required this.name, required this.color});
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '')
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w.isEmpty ? '' : w[0].toUpperCase())
        .join();

    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Small X button in the modal header
class _CloseBtn extends StatefulWidget {
  @override
  State<_CloseBtn> createState() => _CloseBtnState();
}

class _CloseBtnState extends State<_CloseBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 18,
            color: _hovered
                ? ColorValues.textPrimary(context)
                : ColorValues.textSecondary(context),
          ),
        ),
      ),
    );
  }
}