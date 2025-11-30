import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/utils/asset_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/variables.dart';

class CampusBanner extends StatelessWidget {
  const CampusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        color: ColorValues.bgSecondary(context),
      ),
      width: 240,
      padding: EdgeInsets.all(WidthValues.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: WidthValues.spacingSm,
        children: [
          Image.asset(AssetImages.unimetBanner, height: 80),
          Divider(),
          _SelectedTextRow(
            location: context.l10n.locationLabel,
            link: Constants.campusLocation,
          ),
          _SelectedTextRow(
            location: context.l10n.visitWebsiteButtonLabel,
            link: Constants.campusWebsite,
            icon: Icons.web_outlined,
          ),
        ],
      ),
    );
  }
}

class _SelectedTextRow extends StatefulWidget {
  const _SelectedTextRow({
    required this.location,
    required this.link,
    this.icon = Icons.location_on,
  });

  final String location;
  final String link;
  final IconData icon;

  @override
  State<_SelectedTextRow> createState() => _SelectedTextRowState();
}

class _SelectedTextRowState extends State<_SelectedTextRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _isHovered = true),
    onExit: (_) => setState(() => _isHovered = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => launchUrl(Uri.parse(widget.link)),
      child: Row(
        spacing: WidthValues.spacingXs,
        children: [
          Icon(widget.icon, size: 16),
          Text(
            widget.location,
            style: ExtendedTextTheme.textSmall(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
