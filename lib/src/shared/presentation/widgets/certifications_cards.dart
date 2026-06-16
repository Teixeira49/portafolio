import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/variables.dart';
import 'certificate_viewer_modal.dart';

// Mirrors .cert-card: surface card with hover lift, cert-top (icon + name)
// and cert-foot (institution + date + green link).
class CertificationsCard extends StatefulWidget {
  const CertificationsCard({
    super.key,
    required this.title,
    required this.issuingEntity,
    required this.date,
    required this.link,
    this.image,
    this.location,
    this.locationLink,
  });

  final String title;
  final String issuingEntity;
  final String date;
  final String link;
  final String? image;
  final String? location;
  final String? locationLink;

  @override
  State<CertificationsCard> createState() => _CertificationsCardState();
}

class _CertificationsCardState extends State<CertificationsCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => CertificateViewerModal(
            title: widget.title,
            issuingEntity: widget.issuingEntity,
            date: widget.date,
            link: widget.link,
            image: widget.image,
            location: widget.location,
            locationLink: widget.locationLink,
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: ColorValues.bgSurface(context),
            border: Border.all(
              color: _hovered
                  ? ColorValues.borderSurfaceFocus(context)
                  : ColorValues.borderSurface(context),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 34,
                      spreadRadius: -20,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              // .cert-top — icon + name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  _certIcon(context),
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: ColorValues.textPrimary(context),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              // .cert-foot — institution + date + link
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Text(
                          widget.issuingEntity,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: ColorValues.textSecondary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.location != null && widget.location!.isNotEmpty)
                          _LocationLink(
                            location: widget.location!,
                            link: widget.locationLink ?? '',
                          ),
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorValues.textTertiary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _certLink(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // .cert-ico — 40×40 white rounded box with certificate icon
  Widget _certIcon(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: widget.image == null ? Border.all(color: ColorValues.borderSurface(context)) : null,
        borderRadius: BorderRadius.circular(11),
      ),
      child: widget.image != null
          ? Image.asset(widget.image!, fit: BoxFit.cover, width: 40, height: 40)
          : Icon(
              Icons.workspace_premium_outlined,
              size: 22,
              color: Colors.grey.shade600,
            ),
    );
  }

  // .cert-link — green "Ver Certificado" inline link
  Widget _certLink(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 7,
      children: [
        Icon(
          Icons.open_in_new,
          size: 16,
          color: ColorValues.brandGreenSolid(context),
        ),
        Text(
          context.l10n.educationViewCertificateLabel,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: ColorValues.brandGreenSolid(context),
          ),
        ),
      ],
    );
  }
}

class _LocationLink extends StatefulWidget {
  const _LocationLink({required this.location, required this.link});
  final String location;
  final String link;

  @override
  State<_LocationLink> createState() => _LocationLinkState();
}

class _LocationLinkState extends State<_LocationLink> {
  bool _hovered = false;

  bool get _isOnline => widget.location.toLowerCase().contains('online');

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.link.isNotEmpty
            ? () => launchUrl(
                  Uri.parse(widget.link),
                  mode: LaunchMode.externalApplication,
                )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isOnline ? Icons.language : Icons.location_on,
              size: 13,
              color: Color(0xFFE60000),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                widget.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _hovered && widget.link.isNotEmpty
                      ? ColorValues.textSecondary(context)
                      : ColorValues.textTertiary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
