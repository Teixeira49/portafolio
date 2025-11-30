import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/variables.dart';

class CertificationsCard extends StatelessWidget {
  const CertificationsCard({
    super.key,
    required this.title,
    required this.issuingEntity,
    required this.location,
    required this.date,
    required this.link,
  });

  final String title;
  final String issuingEntity;
  final String location;
  final String date;
  final String link;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
      color: ColorValues.bgSecondary(context),
    ),
    padding: EdgeInsets.all(WidthValues.padding),
    child: Column(
      spacing: WidthValues.spacingSm,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: ExtendedTextTheme.titleMedium(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(issuingEntity, style: ExtendedTextTheme.textMedium(context)),
            Text(
              date,
              style: ExtendedTextTheme.textSmall(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        _SelectedTextRow(
          location: "Ver Certificado",
          link: link,
          icon: Icons.link,
        ),
      ],
    ),
  );
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
