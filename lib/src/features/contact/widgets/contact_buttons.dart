part of '../page/contact_modal.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class _SocialChannel {
  const _SocialChannel({
    required this.name,
    required this.handle,
    required this.url,
    required this.bgColor,
    required this.iconPath,
    this.comingSoon = false,
  });

  final String name;
  final String handle;
  final String url;
  final Color bgColor;
  final String iconPath;
  final bool comingSoon;
}

// ---------------------------------------------------------------------------
// Social channel tile
// ---------------------------------------------------------------------------

class _SocialChannelTile extends StatefulWidget {
  const _SocialChannelTile({required this.channel});
  final _SocialChannel channel;

  @override
  State<_SocialChannelTile> createState() => _SocialChannelTileState();
}

class _SocialChannelTileState extends State<_SocialChannelTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isEs = Localizations.localeOf(context).languageCode == 'es';
    final ch = widget.channel;

    final tile = MouseRegion(
      cursor: ch.comingSoon ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: ch.comingSoon
            ? null
            : () => launchUrl(Uri.parse(ch.url), mode: LaunchMode.externalApplication),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered && !ch.comingSoon
                ? ColorValues.bgSidebarHover(context)
                : ColorValues.bgChip(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorValues.borderChip(context)),
          ),
          child: Opacity(
            opacity: ch.comingSoon ? 0.45 : 1.0,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ch.bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    ch.iconPath,
                    fit: BoxFit.contain,
                    colorFilter: const {'GitHub', 'LinkedIn', 'WhatsApp'}
                            .contains(ch.name)
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ch.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorValues.textPrimary(context),
                        ),
                      ),
                      Text(
                        ch.comingSoon
                            ? (isEs ? 'Próximamente' : 'Coming soon')
                            : ch.handle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: ch.comingSoon
                              ? ColorValues.textTertiary(context)
                              : ColorValues.textTertiary(context),
                          fontStyle: ch.comingSoon ? FontStyle.italic : FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!ch.comingSoon)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: ColorValues.textTertiary(context),
                  )
                else
                  Icon(
                    Icons.lock_clock_outlined,
                    size: 14,
                    color: ColorValues.textTertiary(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    if (!ch.comingSoon) return tile;

    return Tooltip(
      message: isEs ? 'Próximamente' : 'Coming soon',
      child: tile,
    );
  }
}

// ---------------------------------------------------------------------------
// Close button
// ---------------------------------------------------------------------------

class _CloseButton extends StatefulWidget {
  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
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
