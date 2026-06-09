import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import '../../../core/providers/providers.dart';
import '../../../core/theme/responsive.dart';
import '../../../core/utils/asset_icons.dart';
import '../../../core/utils/asset_images.dart';
import '../../../core/variables/constants/constants.dart';
import '../../../core/variables/values/values.dart';
import '../../../features/contact/contact.dart';
import '../../../features/home/presentation/bloc/chat_bloc/bloc.dart';
import '../../../features/settings/settings.dart';

// ---------------------------------------------------------------------------
// Collapsed / expanded widths — mirror design: 290px expanded, 78px collapsed
// ---------------------------------------------------------------------------
const double _kExpandedWidth = 290;
const double _kCollapsedWidth = 78;
const Duration _kAnimDuration = Duration(milliseconds: 280);
const Curve _kAnimCurve = Cubic(0.4, 0, 0.2, 1);

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({super.key, required this.width});

  // width is kept for API compatibility with BaseLayoutPage but the panel
  // manages its own expanded/collapsed state internally.
  final double width;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  bool _isExpanded = true;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _kAnimDuration,
      curve: _kAnimCurve,
      width: _isExpanded ? _kExpandedWidth : _kCollapsedWidth,
      decoration: BoxDecoration(
        color: ColorValues.bgSecondary(context),
        border: Border(
          right: BorderSide(
            color: ColorValues.borderLine(context),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header: brand mark + name + collapse button ──────────────────
          _SidebarHeader(
            expanded: _isExpanded,
            onToggle: Responsive.isMobile(context) ? null : _toggle,
          ),

          // ── Nav items ────────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (prev, curr) => prev.chatId != curr.chatId,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _NavItem(
                        id: 0,
                        label: context.l10n.dashboardHomeButton,
                        icon: Icons.home_outlined,
                        routeName: 'home_chat',
                        expanded: _isExpanded,
                      ),
                      _NavItem(
                        id: 1,
                        label: context.l10n.dashboardAboutMeButton,
                        icon: Icons.person_outlined,
                        routeName: 'about_chat',
                        expanded: _isExpanded,
                      ),
                      _NavItem(
                        id: 2,
                        label: context.l10n.dashboardSkillsButton,
                        icon: Icons.workspace_premium_rounded,
                        routeName: 'skills_chat',
                        expanded: _isExpanded,
                      ),
                      _NavItem(
                        id: 3,
                        label: context.l10n.dashboardProjectsButton,
                        icon: Icons.chat_outlined,
                        routeName: 'projects_chat',
                        expanded: _isExpanded,
                      ),
                      _NavItem(
                        id: 4,
                        label: context.l10n.dashboardExperienceButton,
                        icon: Icons.card_travel_rounded,
                        routeName: 'experience_chat',
                        expanded: _isExpanded,
                      ),
                      _NavItem(
                        id: 5,
                        label: context.l10n.dashboardEducationButton,
                        icon: Icons.school_outlined,
                        routeName: 'education_chat',
                        expanded: _isExpanded,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // ── Bottom section ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Settings — ghost button
                _GhostButton(
                  label: context.l10n.dashboardConfigButton,
                  icon: Icons.settings_outlined,
                  expanded: _isExpanded,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const SettingsDialog(),
                  ),
                ),
                const Gap(8),
                // Contact — green CTA button
                _ContactButton(expanded: _isExpanded),
                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 12,
                  ),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: ColorValues.borderLine(context),
                  ),
                ),
                // Profile footer
                _ProfileFooter(expanded: _isExpanded),
                const Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _SidebarHeader extends StatefulWidget {
  const _SidebarHeader({required this.expanded, required this.onToggle});

  final bool expanded;
  final VoidCallback? onToggle;

  @override
  State<_SidebarHeader> createState() => _SidebarHeaderState();
}

class _SidebarHeaderState extends State<_SidebarHeader> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    // ── Collapsed: terminal icon centered → chevron on hover ─────────────────
    if (!widget.expanded && widget.onToggle != null) {
      return Padding(
        // 14px (nav outer) + 12px (nav inner) = 26px — matches nav icon left edge
        padding: const EdgeInsets.fromLTRB(26, 18, 8, 22),
        child: _RightTooltip(
          message: 'Expandir',
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: _hovered
                      ? KeyedSubtree(
                          key: const ValueKey('chevron'),
                          child: _IconButton(
                            icon: Icons.chevron_right,
                            onPressed: widget.onToggle!,
                          ),
                        )
                      : GestureDetector(
                          key: const ValueKey('terminal'),
                          onTap: widget.onToggle,
                          child: SvgPicture.asset(
                            AssetIcons.iconTerminal,
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              ColorValues.textSecondary(context),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ── Expanded: brand icon + name + collapse button ─────────────────────────
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 22),
      child: Row(
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: SvgPicture.asset(
              AssetIcons.iconTerminal,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                ColorValues.textPrimary(context),
                BlendMode.srcIn,
              ),
            ),
          ),
          const Gap(11),
          Expanded(
            child: Text(
              'Ing. Teixeira',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorValues.textPrimary(context),
              ),
            ),
          ),
          if (widget.onToggle != null)
            _RightTooltip(
              message: 'Colapsar',
              child: _IconButton(
                icon: Icons.chevron_left,
                onPressed: widget.onToggle!,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Nav item — pill-shaped, 3-state (default / hover / active)
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.routeName,
    required this.expanded,
  });

  final int id;
  final String label;
  final IconData icon;
  final String routeName;
  final bool expanded;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.chatId != curr.chatId,
      builder: (context, state) {
        final isActive = context.read<ChatBloc>().getChatId() == widget.id;

        Color bg;
        Color fg;
        if (isActive) {
          bg = ColorValues.bgNavPill(context);
          fg = ColorValues.textPrimary(context);
        } else if (_hovered) {
          bg = ColorValues.bgSidebarHover(context);
          fg = ColorValues.textPrimary(context);
        } else {
          bg = Colors.transparent;
          fg = ColorValues.textSecondary(context);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: GestureDetector(
              onTap: () {
                context.read<ChatBloc>().add(GetChatMessages(widget.routeName));
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      isActive ? _getFilledIcon(widget.icon) : widget.icon,
                      color: fg,
                      size: 22,
                    ),
                    const Gap(14),
                    Expanded(
                      child: AnimatedOpacity(
                        duration: _kAnimDuration,
                        opacity: widget.expanded ? 1.0 : 0.0,
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: fg,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getFilledIcon(IconData outlineIcon) {
    final iconMap = {
      Icons.home_outlined: Icons.home,
      Icons.person_outlined: Icons.person,
      Icons.chat_outlined: Icons.chat,
      Icons.school_outlined: Icons.school,
    };
    return iconMap[outlineIcon] ?? outlineIcon;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Contact button — green CTA (.contact-btn)
// ─────────────────────────────────────────────────────────────────────────────

class _ContactButton extends StatefulWidget {
  const _ContactButton({required this.expanded});
  final bool expanded;

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          barrierColor: Colors.black.withAlpha(200),
          builder: (_) => const ContactDialog(),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF00E660).withValues(alpha: 0.88)
                : const Color(0xFF00E660),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mail_outline_rounded,
                color: Color(0xFF03331A),
                size: 19,
              ),
              AnimatedSize(
                duration: _kAnimDuration,
                curve: _kAnimCurve,
                child: widget.expanded
                    ? Row(
                        children: [
                          const Gap(10),
                          Text(
                            context.l10n.dashboardContactButton,
                            style: const TextStyle(
                              color: Color(0xFF03331A),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ghost button — transparent pill, same shape as nav item (.ghost-btn)
// ─────────────────────────────────────────────────────────────────────────────

class _GhostButton extends StatefulWidget {
  const _GhostButton({
    required this.label,
    required this.icon,
    required this.expanded,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool expanded;
  final VoidCallback onPressed;

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _hovered
                    ? ColorValues.textPrimary(context)
                    : ColorValues.textSecondary(context),
                size: 22,
              ),
              const Gap(14),
              AnimatedOpacity(
                duration: _kAnimDuration,
                opacity: widget.expanded ? 1.0 : 0.0,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _hovered
                        ? ColorValues.textPrimary(context)
                        : ColorValues.textSecondary(context),
                  ),
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
// Profile footer (.profile) — clickable, opens profile menu popup
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileFooter extends StatefulWidget {
  const _ProfileFooter({required this.expanded});
  final bool expanded;

  @override
  State<_ProfileFooter> createState() => _ProfileFooterState();
}

class _ProfileFooterState extends State<_ProfileFooter> {
  bool _hovered = false;
  OverlayEntry? _menuEntry;
  String? _addedUserName;

  void _showMenu() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;

    _menuEntry = OverlayEntry(
      builder: (ctx) => _ProfileMenuOverlay(
        anchorBottom: pos.dy,
        anchorLeft: pos.dx,
        anchorWidth: size.width,
        addedUserName: _addedUserName,
        onClose: _hideMenu,
        onSettingsTap: () {
          _hideMenu();
          showDialog(
            context: context,
            builder: (_) => const SettingsDialog(),
          );
        },
        onAddUserTap: () async {
          _hideMenu();
          final result = await showDialog<String>(
            context: context,
            builder: (_) => const _AddUserDialog(),
          );
          if (result != null && result.trim().isNotEmpty) {
            setState(() => _addedUserName = result.trim());
            getIt<AppProvider>().setActiveUserName(result.trim());
          }
        },
        onSignOutTap: () {
          _hideMenu();
          setState(() => _addedUserName = null);
          getIt<AppProvider>().setActiveUserName(null);
        },
        onSelectDefaultUser: () {
          _hideMenu();
          getIt<AppProvider>().setActiveUserName(null);
        },
      ),
    );
    Overlay.of(context).insert(_menuEntry!);
  }

  void _hideMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _showMenu,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              // Avatar — profile photo
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF303233)),
                ),
                child: ClipOval(
                  child: Image.asset(
                    AssetImages.profile,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF2B2D2E),
                      alignment: Alignment.center,
                      child: Text(
                        'JT',
                        style: TextStyle(
                          color: ColorValues.textSecondary(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(11),
              // Name + role — animated opacity
              Expanded(
                child: AnimatedOpacity(
                  duration: _kAnimDuration,
                  opacity: widget.expanded ? 1.0 : 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Constants.developerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: ColorValues.textPrimary(context),
                        ),
                      ),
                      Text(
                        context.l10n.resumeTitleLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: ColorValues.textTertiary(context),
                        ),
                      ),
                    ],
                  ),
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
// Profile menu overlay — popup card shown above the profile footer
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileMenuOverlay extends StatefulWidget {
  const _ProfileMenuOverlay({
    required this.anchorBottom,
    required this.anchorLeft,
    required this.anchorWidth,
    required this.onClose,
    required this.onSettingsTap,
    required this.onAddUserTap,
    required this.onSignOutTap,
    required this.onSelectDefaultUser,
    this.addedUserName,
  });

  final double anchorBottom;
  final double anchorLeft;
  final double anchorWidth;
  final VoidCallback onClose;
  final VoidCallback onSettingsTap;
  final VoidCallback onAddUserTap;
  final VoidCallback onSignOutTap;
  final VoidCallback onSelectDefaultUser;
  final String? addedUserName;

  @override
  State<_ProfileMenuOverlay> createState() => _ProfileMenuOverlayState();
}

class _ProfileMenuOverlayState extends State<_ProfileMenuOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    await _ctrl.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    const menuWidth = 320.0;
    const menuGap = 8.0;

    // Position popup above the profile footer, left-aligned with the sidebar
    final left = widget.anchorLeft;
    final bottom = MediaQuery.of(context).size.height - widget.anchorBottom + menuGap;

    return Stack(
      children: [
        // Dismiss barrier
        Positioned.fill(
          child: GestureDetector(
            onTap: _close,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),
        // The card
        Positioned(
          left: left,
          bottom: bottom,
          width: menuWidth,
          child: FadeTransition(
            opacity: _opacity,
            child: SlideTransition(
              position: _slide,
              child: _ProfileMenuCard(
                onClose: _close,
                onSettingsTap: widget.onSettingsTap,
                onAddUserTap: widget.onAddUserTap,
                onSignOutTap: widget.onSignOutTap,
                onSelectDefaultUser: widget.onSelectDefaultUser,
                addedUserName: widget.addedUserName,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile menu card content
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileMenuCard extends StatelessWidget {
  const _ProfileMenuCard({
    required this.onClose,
    required this.onSettingsTap,
    required this.onAddUserTap,
    required this.onSignOutTap,
    required this.onSelectDefaultUser,
    this.addedUserName,
  });

  final VoidCallback onClose;
  final VoidCallback onSettingsTap;
  final VoidCallback onAddUserTap;
  final VoidCallback onSignOutTap;
  final VoidCallback onSelectDefaultUser;
  final String? addedUserName;

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  String _generateEmail(String name) {
    final slug = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return '$slug@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuBg = isDark ? const Color(0xFF202223) : Colors.white;
    final lineColor = ColorValues.borderLine(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: menuBg,
          border: Border.all(color: lineColor),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.18),
              blurRadius: 50,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Top row: label centered + close button pinned right ──────
            SizedBox(
              height: 30,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Perfil del usuario',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: ColorValues.textSecondary(context),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: _MenuIconBtn(
                      icon: Icons.close_rounded,
                      onPressed: onClose,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(4),
            // ── Avatar with green ring ───────────────────────────────────
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E660).withValues(alpha: 0.55),
                    blurRadius: 0,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  AssetImages.profile,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF2B2D2E),
                    alignment: Alignment.center,
                    child: const Text(
                      'JT',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            // ── Greeting ────────────────────────────────────────────────
            Text(
              '¡Hola, Javier!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorValues.textPrimary(context),
              ),
            ),
            const Gap(14),
            // ── Divider + rows ───────────────────────────────────────────
            Divider(height: 1, thickness: 1, color: lineColor),
            const Gap(8),
            _PfRow(
              icon: Icons.settings_outlined,
              label: 'Ajustes',
              onTap: onSettingsTap,
            ),
            // ── Divider + Más perfiles ───────────────────────────────────
            const Gap(4),
            Divider(height: 1, thickness: 1, color: lineColor),
            const Gap(8),
            // "Más perfiles" header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'Más perfiles',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorValues.textTertiary(context),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(4),
            // Second profile row
            _PfProfileRow(
              name: 'Usuario',
              email: 'youruser@gmail.com',
              initials: 'YU',
              color: const Color(0xFF1F55C4),
              onTap: onSelectDefaultUser,
            ),
            const Gap(2),
            // ── Added user or "Añadir usuario" ───────────────────────────
            if (addedUserName != null) ...[
              _PfProfileRow(
                name: addedUserName!,
                email: _generateEmail(addedUserName!),
                initials: _getInitials(addedUserName!),
                color: const Color(0xFF7C3AED),
              ),
              const Gap(2),
              Divider(height: 1, thickness: 1, color: lineColor),
              const Gap(4),
              _PfRow(
                icon: Icons.logout_rounded,
                label: 'Cerrar sesión',
                onTap: onSignOutTap,
              ),
            ] else
              _AddUserRow(onTap: onAddUserTap),
            const Gap(2),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "Añadir usuario" row — shown when no custom user has been added yet
// ─────────────────────────────────────────────────────────────────────────────

class _AddUserRow extends StatefulWidget {
  const _AddUserRow({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_AddUserRow> createState() => _AddUserRowState();
}

class _AddUserRowState extends State<_AddUserRow> {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorValues.borderLine(context),
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_rounded,
                  size: 18,
                  color: ColorValues.textSecondary(context),
                ),
              ),
              const Gap(12),
              Text(
                'Añadir usuario',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? ColorValues.textPrimary(context)
                      : ColorValues.textSecondary(context),
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
// Dialog for entering a new user name
// ─────────────────────────────────────────────────────────────────────────────

class _AddUserDialog extends StatefulWidget {
  const _AddUserDialog();

  @override
  State<_AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<_AddUserDialog> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF202223) : Colors.white;
    final lineColor = ColorValues.borderLine(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: lineColor),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.55 : 0.18),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Añadir usuario',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorValues.textPrimary(context),
                    ),
                  ),
                ),
                _MenuIconBtn(
                  icon: Icons.close_rounded,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Gap(16),
            // Text field
            TextField(
              controller: _controller,
              autofocus: true,
              maxLength: 30,
              textCapitalization: TextCapitalization.words,
              onSubmitted: (v) {
                if (v.trim().isNotEmpty) Navigator.of(context).pop(v.trim());
              },
              style: TextStyle(
                fontSize: 14.5,
                color: ColorValues.textPrimary(context),
              ),
              decoration: InputDecoration(
                hintText: 'Tu nombre',
                hintStyle: TextStyle(
                  color: ColorValues.textTertiary(context),
                  fontSize: 14.5,
                ),
                filled: true,
                fillColor: isDark
                    ? const Color(0xFF2B2D2E)
                    : const Color(0xFFF4F4F5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF00E660),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const Gap(16),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: ColorValues.textSecondary(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(8),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _hasText ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: _hasText
                        ? () => Navigator.of(context)
                            .pop(_controller.text.trim())
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E660),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Color(0xFF03331A),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile menu row (icon + label)
// ─────────────────────────────────────────────────────────────────────────────

class _PfRow extends StatefulWidget {
  const _PfRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_PfRow> createState() => _PfRowState();
}

class _PfRowState extends State<_PfRow> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: _hovered
                    ? ColorValues.textPrimary(context)
                    : ColorValues.textSecondary(context),
              ),
              const Gap(13),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? ColorValues.textPrimary(context)
                      : ColorValues.textSecondary(context),
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
// Secondary profile row in "Más perfiles" section
// ─────────────────────────────────────────────────────────────────────────────

class _PfProfileRow extends StatefulWidget {
  const _PfProfileRow({
    required this.name,
    required this.email,
    required this.initials,
    required this.color,
    this.onTap,
  });

  final String name;
  final String email;
  final String initials;
  final Color color;
  final VoidCallback? onTap;

  @override
  State<_PfProfileRow> createState() => _PfProfileRowState();
}

class _PfProfileRowState extends State<_PfProfileRow> {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Avatar circle with initials
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorValues.textPrimary(context),
                      ),
                    ),
                    Text(
                      widget.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorValues.textTertiary(context),
                      ),
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
// Small icon button used in the profile menu header
// ─────────────────────────────────────────────────────────────────────────────

class _MenuIconBtn extends StatefulWidget {
  const _MenuIconBtn({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_MenuIconBtn> createState() => _MenuIconBtnState();
}

class _MenuIconBtnState extends State<_MenuIconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgChipHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            size: 17,
            color: _hovered
                ? ColorValues.textPrimary(context)
                : ColorValues.textSecondary(context),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Right-side tooltip — shows a tooltip to the right of its child via Overlay
// ─────────────────────────────────────────────────────────────────────────────

class _RightTooltip extends StatefulWidget {
  const _RightTooltip({required this.message, required this.child});
  final String message;
  final Widget child;

  @override
  State<_RightTooltip> createState() => _RightTooltipState();
}

class _RightTooltipState extends State<_RightTooltip> {
  OverlayEntry? _entry;

  void _show(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    _entry = OverlayEntry(
      builder: (_) => Positioned(
        left: pos.dx + size.width + 8,
        top: pos.dy + size.height / 2 - 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              widget.message,
              style: const TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _show(context),
      onExit: (_) => _hide(),
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small icon button — used for the collapse toggle (.icon-btn)
// ─────────────────────────────────────────────────────────────────────────────

class _IconButton extends StatefulWidget {
  const _IconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<_IconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: _hovered
                ? ColorValues.textPrimary(context)
                : ColorValues.textSecondary(context),
          ),
        ),
      ),
    );
  }
}
