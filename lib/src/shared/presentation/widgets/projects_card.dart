import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/utils/asset_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/responsive.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/variables/variables.dart';

// ---------------------------------------------------------------------------
// ProjectCard
// ---------------------------------------------------------------------------

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.name,
    required this.initDate,
    required this.endDate,
    required this.technologies,
    required this.repository,
    required this.link,
    required this.prototype,
    required this.description,
    required this.private,
    required this.cardWidth,
    this.isFavorite = false,
    this.educationalInstitution,
  });

  final String name;
  final String initDate;
  final String endDate;
  final List<String> technologies;
  final List repository;
  final String? link;
  final Map<String, dynamic> description;
  final String? prototype;
  final bool private;
  // Pre-computed card width so _TechBadgesRow can avoid LayoutBuilder.
  final double cardWidth;
  final bool isFavorite;
  final String? educationalInstitution;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  String _localizedDesc(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return (widget.description[locale] ?? widget.description['en'] ?? '').toString();
  }

  // card horizontal padding (left + right) + border (×2) + gap + link button
  double _badgesAvailableWidth() {
    const hPad = (16.0 + 8.0) * 2; // spacingMd + spacingXs, both sides
    const border = 2.0;
    const gap = 12.0; // spacingSm
    const linkBtn = 42.0;
    return widget.cardWidth - hPad - border - gap - linkBtn;
  }

  void _openModal(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withAlpha(140),
      builder: (_) => _ProjectDetailModal(project: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shortMonth = Responsive.isMobile(context);

    return GestureDetector(
      onTap: () => _openModal(context),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WidthValues.radiusLg),
            color: ColorValues.bgSurface(context),
            border: Border.all(
              color: _isHovered
                  ? ColorValues.borderSurfaceFocus(context)
                  : ColorValues.borderSurface(context),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(166),
                      blurRadius: 46,
                      spreadRadius: -22,
                      offset: const Offset(0, 18),
                    ),
                  ]
                : [],
          ),
          padding: EdgeInsets.fromLTRB(
            WidthValues.spacingMd + WidthValues.spacingXs,
            WidthValues.spacingMd + WidthValues.spacingXs,
            WidthValues.spacingMd + WidthValues.spacingXs,
            WidthValues.spacingMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: ExtendedTextTheme.titleMedium(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.isFavorite) ...[
                    const SizedBox(width: 6),
                    Tooltip(
                      message: context.l10n.projectFavoriteTooltip,
                      child: const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFFFBE00),
                      ),
                    ),
                  ],
                  if (widget.educationalInstitution != null) ...[
                    const SizedBox(width: 4),
                    Tooltip(
                      message: context.l10n.projectEducationalTooltip(
                        widget.educationalInstitution!,
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 16,
                        color: Color(0xFF7FA8FF),
                      ),
                    ),
                  ],
                ],
              ),
              Gap(WidthValues.spacingXxs),
              Text(
                '${Helpers.getParsedDate(context, widget.initDate, shortMonth: shortMonth)} – '
                '${Helpers.getParsedDate(context, widget.endDate, shortMonth: shortMonth)}',
                style: ExtendedTextTheme.textSmall(context).copyWith(
                  color: ColorValues.textTertiary(context),
                  fontWeight: FontWeight.w600,
                  letterSpacing: .2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(WidthValues.spacingXs),
              Text(
                _localizedDesc(context),
                style: ExtendedTextTheme.textMedium(context).copyWith(
                  color: ColorValues.textSecondary(context),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Gap(WidthValues.spacingSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: _TechBadgesRow(
                      technologies: widget.technologies,
                      availableWidth: _badgesAvailableWidth(),
                      onOverflowTap: () => _openModal(context),
                    ),
                  ),
                  Gap(WidthValues.spacingSm),
                  if (widget.prototype != null)
                    _ProjectLinkButton(
                      asset: AssetIcons.iconFigma,
                      onTap: () => launchUrl(Uri.parse(widget.prototype!)),
                    )
                  else if (widget.repository.isNotEmpty && !widget.private)
                    _ProjectPopMenuButton(options: widget.repository)
                  else
                    Tooltip(
                      message: context.l10n.projectIsPrivateLabel,
                      child: _ProjectLinkButton(
                        asset: AssetIcons.iconLock,
                        isLocked: true,
                        onTap: null,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tech badges row — max 2 visible rows, "…" overflow badge
// ---------------------------------------------------------------------------

class _TechBadgesRow extends StatelessWidget {
  const _TechBadgesRow({
    required this.technologies,
    required this.availableWidth,
    required this.onOverflowTap,
  });

  final List<String> technologies;
  final double availableWidth;
  final VoidCallback onOverflowTap;

  static const double _hPad = 13.0 * 2;
  static const double _itemSpacing = 8.0;
  static const int _maxRows = 2;

  double _measureBadge(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return tp.width.ceilToDouble() + _hPad + 2;
  }

  @override
  Widget build(BuildContext context) {
    if (technologies.isEmpty) return const SizedBox.shrink();

    final style = ExtendedTextTheme.titleExtraSmall(context);
    final maxWidth = availableWidth.clamp(80.0, double.infinity);

    int row = 1;
    double rowWidth = 0;
    final visible = <int>[];
    bool overflow = false;

    for (int i = 0; i < technologies.length; i++) {
      final w = _measureBadge(technologies[i], style);
      final needed = rowWidth == 0 ? w : rowWidth + _itemSpacing + w;

      if (needed > maxWidth) {
        row++;
        if (row > _maxRows) {
          overflow = true;
          break;
        }
        rowWidth = w;
      } else {
        rowWidth = needed;
      }
      visible.add(i);
    }

    if (overflow) {
      final overW = _measureBadge('…', style);
      final withOver = rowWidth == 0 ? overW : rowWidth + _itemSpacing + overW;
      if (withOver > maxWidth && visible.isNotEmpty) {
        visible.removeLast();
      }
    }

    return Wrap(
      spacing: _itemSpacing,
      runSpacing: _itemSpacing,
      children: [
        ...visible.map((i) => _TechBadge(name: technologies[i], index: i)),
        if (overflow) _OverflowBadge(onTap: onOverflowTap),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Individual tech badge — tri-color cycling: green → blue → red
// ---------------------------------------------------------------------------

class _TechBadge extends StatelessWidget {
  const _TechBadge({required this.name, required this.index});

  final String name;
  final int index;

  static const _darkBg = [
    Color(0x2100E660),
    Color(0x261E50F0),
    Color(0x21E60000),
  ];
  static const _darkBorder = [
    Color(0x5200E660),
    Color(0x5C4F8CFA),
    Color(0x57FF4646),
  ];
  static const _darkFg = [
    Color(0xFF3EF08A),
    Color(0xFF7FA8FF),
    Color(0xFFFF7A7A),
  ];
  static const _lightBg = [
    Color(0x2400C854),
    Color(0x1F3C78F0),
    Color(0x1AE60000),
  ];
  static const _lightFg = [
    Color(0xFF0A8F43),
    Color(0xFF2554C4),
    Color(0xFFC41F1F),
  ];

  @override
  Widget build(BuildContext context) {
    final i = index % 3;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WidthValues.radiusLg),
        color: isDark ? _darkBg[i] : _lightBg[i],
        border: Border.all(
          color: isDark ? _darkBorder[i] : _darkBorder[i].withAlpha(100),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: WidthValues.spacingXs + WidthValues.spacingXxs + 1,
        vertical: WidthValues.spacingXxs + 2,
      ),
      child: Text(
        name,
        style: ExtendedTextTheme.titleExtraSmall(context).copyWith(
          color: isDark ? _darkFg[i] : _lightFg[i],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Overflow badge — "…" indicator
// ---------------------------------------------------------------------------

class _OverflowBadge extends StatefulWidget {
  const _OverflowBadge({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_OverflowBadge> createState() => _OverflowBadgeState();
}

class _OverflowBadgeState extends State<_OverflowBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WidthValues.radiusLg),
            color: _hovered
                ? ColorValues.bgChipHover(context)
                : ColorValues.bgChip(context),
            border: Border.all(color: ColorValues.borderChip(context)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: WidthValues.spacingXs + WidthValues.spacingXxs + 1,
            vertical: WidthValues.spacingXxs + 2,
          ),
          child: Text(
            '…',
            style: ExtendedTextTheme.titleExtraSmall(context).copyWith(
              color: ColorValues.textTertiary(context),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 42 × 42 icon link button (Figma, lock)
// ---------------------------------------------------------------------------

class _ProjectLinkButton extends StatefulWidget {
  const _ProjectLinkButton({
    required this.asset,
    required this.onTap,
    this.isLocked = false,
  });

  final String asset;
  final VoidCallback? onTap;
  final bool isLocked;

  @override
  State<_ProjectLinkButton> createState() => _ProjectLinkButtonState();
}

class _ProjectLinkButtonState extends State<_ProjectLinkButton> {
  bool _hovered = false;

  Color _iconColor(BuildContext context) {
    if (!_hovered) return ColorValues.fgTertiary(context);
    if (widget.isLocked) return ColorValues.brandRedSolid(context);
    return ColorValues.fgPrimary(context);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isLocked ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WidthValues.radiusSm),
            color: _hovered
                ? ColorValues.bgChipHover(context)
                : ColorValues.bgChip(context),
          ),
          child: Center(
            child: SvgPicture.asset(
              widget.asset,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(_iconColor(context), BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 42 × 42 popup menu button (GitHub with multiple repos)
// ---------------------------------------------------------------------------

class _ProjectPopMenuButton extends StatefulWidget {
  const _ProjectPopMenuButton({required this.options});
  final List options;

  @override
  State<_ProjectPopMenuButton> createState() => _ProjectPopMenuButtonState();
}

class _ProjectPopMenuButtonState extends State<_ProjectPopMenuButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WidthValues.radiusSm),
          color: _hovered
              ? ColorValues.bgChipHover(context)
              : ColorValues.bgChip(context),
        ),
        child: PopupMenuButton<String>(
          color: ColorValues.bgPrimary(context),
          padding: EdgeInsets.zero,
          tooltip: '',
          icon: SvgPicture.asset(
            AssetIcons.iconGithubLight,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(
              _hovered
                  ? ColorValues.fgPrimary(context)
                  : ColorValues.fgTertiary(context),
              BlendMode.srcIn,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WidthValues.radiusMd),
          ),
          position: PopupMenuPosition.under,
          itemBuilder: (context) => widget.options
              .map<PopupMenuItem<String>>((repo) => PopupMenuItem<String>(
                    value: repo['link'] as String,
                    onTap: () => launchUrl(Uri.parse(repo['link'] as String)),
                    child: Text(
                      repo['name'] as String,
                      style: ExtendedTextTheme.textMedium(context),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Project detail modal
// ---------------------------------------------------------------------------

class _ProjectDetailModal extends StatelessWidget {
  const _ProjectDetailModal({required this.project});
  final ProjectCard project;

  String _localizedDesc(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return (project.description[locale] ?? project.description['en'] ?? '')
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final isEs = Localizations.localeOf(context).languageCode == 'es';
    final shortMonth = Responsive.isMobile(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860, maxHeight: 600),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: ColorValues.bgSurface(context),
                border: Border.all(color: ColorValues.borderLine(context)),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(180),
                    blurRadius: 90,
                    spreadRadius: -20,
                    offset: const Offset(0, 30),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(30, 28, 30, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ──────────────────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: ColorValues.textPrimary(context),
                                ),
                              ),
                              const Gap(6),
                              Text(
                                '${Helpers.getParsedDate(context, project.initDate, shortMonth: shortMonth)} – '
                                '${Helpers.getParsedDate(context, project.endDate, shortMonth: shortMonth)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorValues.textTertiary(context),
                                  letterSpacing: .2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _ModalCloseButton(),
                      ],
                    ),

                    // ── Description ─────────────────────────────────────────
                    const Gap(18),
                    Text(
                      _localizedDesc(context),
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: ColorValues.textSecondary(context),
                      ),
                    ),

                    // ── Technologies ────────────────────────────────────────
                    const Gap(22),
                    Text(
                      isEs ? 'TECNOLOGÍAS' : 'TECHNOLOGIES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .5,
                        color: ColorValues.textTertiary(context),
                      ),
                    ),
                    const Gap(10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies
                          .asMap()
                          .entries
                          .map((e) => _TechBadge(name: e.value, index: e.key))
                          .toList(),
                    ),

                    // ── Project type tags ────────────────────────────────────
                    if (project.isFavorite || project.educationalInstitution != null) ...[
                      const Gap(22),
                      Text(
                        isEs ? 'TIPO DE PROYECTO' : 'PROJECT TYPE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .5,
                          color: ColorValues.textTertiary(context),
                        ),
                      ),
                      const Gap(10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (project.isFavorite)
                            _ProjectTagChip(
                              icon: Icons.star_rounded,
                              iconColor: const Color(0xFFFFBE00),
                              label: context.l10n.projectFavoriteTooltip,
                              bgColor: const Color(0x22FFD000),
                              borderColor: const Color(0x55FFB800),
                            ),
                          if (project.educationalInstitution != null)
                            _ProjectTagChip(
                              icon: Icons.school_rounded,
                              iconColor: const Color(0xFF7FA8FF),
                              label: context.l10n.projectEducationalTooltip(
                                project.educationalInstitution!,
                              ),
                              bgColor: const Color(0x221E50F0),
                              borderColor: const Color(0x554F8CFA),
                            ),
                        ],
                      ),
                    ],

                    // ── Action buttons ──────────────────────────────────────
                    const Gap(24),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _buildActions(context, isEs),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, bool isEs) {
    final actions = <Widget>[];

    if (project.prototype != null) {
      actions.add(_ModalActionButton(
        icon: SvgPicture.asset(
          AssetIcons.iconFigma,
          width: 18,
          height: 18,
          colorFilter:
              const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        label: isEs ? 'Ver prototipo' : 'View prototype',
        isPrimary: true,
        onTap: () => launchUrl(Uri.parse(project.prototype!)),
      ));
    }

    if (project.repository.isNotEmpty && !project.private) {
      for (final repo in project.repository) {
        actions.add(_ModalActionButton(
          icon: SvgPicture.asset(
            AssetIcons.iconGithubLight,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              ColorValues.textPrimary(context),
              BlendMode.srcIn,
            ),
          ),
          label: repo['name'] as String,
          isPrimary: project.prototype == null && actions.isEmpty,
          onTap: () => launchUrl(Uri.parse(repo['link'] as String)),
        ));
      }
    }

    if (project.link != null && (project.link!).isNotEmpty) {
      actions.add(_ModalActionButton(
        icon: Icon(
          Icons.open_in_new_rounded,
          size: 18,
          color: ColorValues.textPrimary(context),
        ),
        label: isEs ? 'Visitar' : 'Visit',
        onTap: () => launchUrl(Uri.parse(project.link!)),
      ));
    }

    if (project.private) {
      actions.add(_ModalActionButton(
        icon: SvgPicture.asset(
          AssetIcons.iconLock,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(
            ColorValues.brandRedSolid(context),
            BlendMode.srcIn,
          ),
        ),
        label: isEs ? 'Proyecto privado' : 'Private project',
        isPrivate: true,
        onTap: null,
      ));
    }

    return actions;
  }
}

// ── Modal close button ───────────────────────────────────────────────────────

class _ModalCloseButton extends StatefulWidget {
  @override
  State<_ModalCloseButton> createState() => _ModalCloseButtonState();
}

class _ModalCloseButtonState extends State<_ModalCloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WidthValues.radiusSm),
            color: _hovered
                ? ColorValues.bgChipHover(context)
                : Colors.transparent,
          ),
          child: Icon(
            Icons.close_rounded,
            size: 18,
            color: _hovered
                ? ColorValues.fgPrimary(context)
                : ColorValues.fgTertiary(context),
          ),
        ),
      ),
    );
  }
}

// ── Project tag chip (used in modal "Project Type" section) ─────────────────

class _ProjectTagChip extends StatelessWidget {
  const _ProjectTagChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.bgColor,
    required this.borderColor,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final Color bgColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WidthValues.radiusLg),
        color: bgColor,
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: ExtendedTextTheme.titleExtraSmall(context).copyWith(
              color: ColorValues.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Modal action button ──────────────────────────────────────────────────────

class _ModalActionButton extends StatefulWidget {
  const _ModalActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    this.isPrivate = false,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;
  final bool isPrimary;
  final bool isPrivate;

  @override
  State<_ModalActionButton> createState() => _ModalActionButtonState();
}

class _ModalActionButtonState extends State<_ModalActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryBg = ColorValues.brandBlueSolid(context);

    Color bg() {
      if (widget.isPrivate) return Colors.transparent;
      if (widget.isPrimary) return _hovered ? primaryBg.withAlpha(220) : primaryBg;
      return _hovered ? ColorValues.bgChipHover(context) : ColorValues.bgChip(context);
    }

    Color fg() {
      if (widget.isPrivate) return ColorValues.brandRedSolid(context);
      if (widget.isPrimary) return Colors.white;
      return ColorValues.textPrimary(context);
    }

    Color border() {
      if (widget.isPrivate) return Colors.transparent;
      if (widget.isPrimary) return primaryBg;
      return ColorValues.borderChip(context);
    }

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: bg(),
            border: Border.all(color: border()),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon,
              const Gap(9),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: fg(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}