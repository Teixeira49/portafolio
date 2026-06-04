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
  });

  final String name;
  final String handle;
  final String url;
  final Color bgColor;
  final String iconPath;
}

// ---------------------------------------------------------------------------
// Social channel tile — icon + name + handle, tappable with launchUrl
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.channel.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : ColorValues.bgChip(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorValues.borderChip(context)),
          ),
          child: Row(
            children: [
              // Brand icon in colored square
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.channel.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  widget.channel.iconPath,
                  fit: BoxFit.contain,
                  colorFilter: widget.channel.name == 'GitHub'
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
                      widget.channel.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorValues.textPrimary(context),
                      ),
                    ),
                    Text(
                      widget.channel.handle,
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
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: ColorValues.textTertiary(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Close button (top-right of social panel)
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
