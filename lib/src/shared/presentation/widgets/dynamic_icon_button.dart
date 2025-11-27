import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/values/values.dart';

class DynamicIconButton extends StatefulWidget {
  const DynamicIconButton({
    super.key,
    required this.asset,
    required this.route,
  });

  final String asset;
  final String? route;

  @override
  State<DynamicIconButton> createState() => DynamicIconButtonState();
}

class DynamicIconButtonState extends State<DynamicIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _isHovered ? null : Colors.blueGrey;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      // Cambia el cursor a una mano para indicar que es clickeable
      child: InkWell(
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
  });

  final String asset;
  final List options;

  @override
  State<DynamicIconPopMenu> createState() => DynamicIconPopMenuState();
}

class DynamicIconPopMenuState extends State<DynamicIconPopMenu> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _isHovered ? null : Colors.blueGrey;

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
