import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/variables/values/values.dart';
import '../../domain/entities/enums/skill_level.dart';
import 'skill_detail_modal.dart';

// Level accent colors — mirror the design's data-lvl CSS rules
const _kColorHigh   = Color(0xFF00E660); // --c-green
const _kColorMedium = Color(0xFF5B8EF0); // design medium blue
const _kColorLow    = Color(0xFFFF5A5A); // design low red

Color _levelColor(SkillLevel level) => switch (level) {
      SkillLevel.high   => _kColorHigh,
      SkillLevel.medium => _kColorMedium,
      SkillLevel.low    => _kColorLow,
    };

int _activeBars(SkillLevel level) => switch (level) {
      SkillLevel.high   => 3,
      SkillLevel.medium => 2,
      SkillLevel.low    => 1,
    };

class SkillsCard extends StatefulWidget {
  const SkillsCard({
    super.key,
    required this.title,
    this.asset,
    required this.level,
    this.color,
  });

  final String title;
  final String? asset;
  final SkillLevel level;
  final Color? color;

  @override
  State<SkillsCard> createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => showSkillDetailModal(
          context: context,
          skillName: widget.title,
          level: widget.level,
          assetPath: widget.asset,
          accentColor: widget.color,
        ),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        // hover: slide up 2 px
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        decoration: BoxDecoration(
          color: ColorValues.bgSurface(context),
          border: Border.all(
            color: _hovered
                ? ColorValues.borderSurfaceFocus(context)
                : ColorValues.borderSurface(context),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? const [
                  BoxShadow(
                    color: Color(0x991A1A1A),
                    blurRadius: 30,
                    spreadRadius: -16,
                    offset: Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon container (.skill-ico): 44×44, white bg, 12 px radius
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorValues.borderSurface(context)),
              ),
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              child: _SkillIcon(
                asset: widget.asset,
                color: widget.color,
              ),
            ),
            const SizedBox(width: 13),
            // Meta section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // .skill-name
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ColorValues.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // .skill-lvl
                  Row(
                    children: [
                      _LvlBars(
                        level: widget.level,
                        dimColor: ColorValues.bgChipHover(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.level.levelTitle(context),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: _levelColor(widget.level),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Icon inside the white container
// ─────────────────────────────────────────────────────────────────────────────

class _SkillIcon extends StatelessWidget {
  const _SkillIcon({this.asset, this.color});
  final String? asset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (asset == null) {
      // Monogram fallback
      return Container(
        color: color ?? Colors.grey,
        alignment: Alignment.center,
        child: const Text(
          '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }

    // Show SVG at 27×27 — no color filter: white container ensures
    // all icons are readable regardless of their source color.
    return SvgPicture.asset(
      asset!,
      width: 27,
      height: 27,
      fit: BoxFit.contain,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Level bars: 3 segments (15 × 4 px, 2 px radius, 3 px gap)
// Active count: high=3, medium=2, low=1
// ─────────────────────────────────────────────────────────────────────────────

class _LvlBars extends StatelessWidget {
  const _LvlBars({required this.level, required this.dimColor});
  final SkillLevel level;
  final Color dimColor;

  @override
  Widget build(BuildContext context) {
    final active = _activeBars(level);
    final accent = _levelColor(level);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Container(
          width: 15,
          height: 4,
          margin: i < 2 ? const EdgeInsets.only(right: 3) : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: i < active ? accent : dimColor,
          ),
        );
      }),
    );
  }
}
