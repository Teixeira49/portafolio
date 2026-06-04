import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import '../../../core/theme/responsive.dart';
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
                // Contact — green CTA button
                _ContactButton(expanded: _isExpanded),
                const Gap(8),
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

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({required this.expanded, required this.onToggle});

  final bool expanded;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 22),
      child: Row(
        children: [
          // Brand mark — fades out when collapsed
          AnimatedOpacity(
            duration: _kAnimDuration,
            opacity: expanded ? 1.0 : 0.0,
            child: AnimatedContainer(
              duration: _kAnimDuration,
              width: expanded ? 34 : 0,
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFFE60000),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'JT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: _kAnimDuration,
            curve: _kAnimCurve,
            child: SizedBox(width: expanded ? 11 : 0),
          ),
          // Brand name — fades out when collapsed
          Expanded(
            child: AnimatedOpacity(
              duration: _kAnimDuration,
              opacity: expanded ? 1.0 : 0.0,
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
          ),
          // Collapse toggle button (desktop only)
          if (onToggle != null)
            _IconButton(
              icon: expanded ? Icons.chevron_left : Icons.chevron_right,
              onPressed: onToggle!,
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
          fg = Colors.white;
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
                    Icon(widget.icon, color: fg, size: 22),
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
// Profile footer (.profile)
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileFooter extends StatelessWidget {
  const _ProfileFooter({required this.expanded});
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          // Avatar — gradient circle with "JT" initials
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3A3C3D), Color(0xFF202122)],
              ),
              border: Border.all(color: const Color(0xFF303233)),
            ),
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
          const Gap(11),
          // Name + role — animated opacity
          Expanded(
            child: AnimatedOpacity(
              duration: _kAnimDuration,
              opacity: expanded ? 1.0 : 0.0,
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
