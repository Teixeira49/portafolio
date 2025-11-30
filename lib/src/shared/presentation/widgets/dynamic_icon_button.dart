import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/values/values.dart';

class DynamicIconButton extends StatefulWidget {
  const DynamicIconButton({
    super.key,
    required this.asset,
    required this.route,
    this.maskColor,
  });

  final String asset;
  final String? route;
  final Color? maskColor;

  @override
  State<DynamicIconButton> createState() => DynamicIconButtonState();
}

class DynamicIconButtonState extends State<DynamicIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _isHovered ? widget.maskColor : ColorValues.utilityGray400(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(WidthValues.radiusXxs),
        onTap:
            () =>
                widget.route != null
                    ? launchUrl(Uri.parse(widget.route!))
                    : null,
        child: SvgPicture.asset(
          widget.asset,
          width: 25,
          height: 25,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}

class DynamicIconPopMenu extends StatefulWidget {
  const DynamicIconPopMenu({
    super.key,
    required this.asset,
    required this.options,
    this.maskColor,
  });

  final String asset;
  final List options;
  final Color? maskColor;

  @override
  State<DynamicIconPopMenu> createState() => DynamicIconPopMenuState();
}

class DynamicIconPopMenuState extends State<DynamicIconPopMenu> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _isHovered ? widget.maskColor : ColorValues.utilityGray400(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton(
        icon: SvgPicture.asset(
          widget.asset,
          width: 25,
          height: 25,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        ),
        position: PopupMenuPosition.under,
        itemBuilder:
            (context) =>
                widget.options.map((repository) {
                  return PopupMenuItem(
                    value: repository["link"],
                    child: Text(repository["name"]),
                    onTap: () => launchUrl(Uri.parse(repository["link"])),
                  );
                }).toList(),
      ),
    );
  }
}
