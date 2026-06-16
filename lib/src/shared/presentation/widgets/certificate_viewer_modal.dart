// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/values/values.dart';

// ── Drive URL → embed URL ─────────────────────────────────────────────────────
// Google Drive links use the form:  .../file/d/{ID}/view?...
// The embeddable preview form is:   .../file/d/{ID}/preview
// This lets the iframe render the document without requiring sign-in.
String _toEmbedUrl(String driveUrl) {
  final match = RegExp(r'/d/([^/?]+)').firstMatch(driveUrl);
  if (match != null) {
    return 'https://drive.google.com/file/d/${match.group(1)}/preview';
  }
  return driveUrl;
}

// ── Unique view-type counter (shared with curriculum modal counter space) ─────
int _certIframeCounter = 0;

// ─────────────────────────────────────────────────────────────────────────────

class CertificateViewerModal extends StatefulWidget {
  const CertificateViewerModal({
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
  State<CertificateViewerModal> createState() => _CertificateViewerModalState();
}

class _CertificateViewerModalState extends State<CertificateViewerModal> {
  late final String _viewType;
  late final String _embedUrl;
  late final html.IFrameElement _iframe;

  @override
  void initState() {
    super.initState();
    _embedUrl = _toEmbedUrl(widget.link);
    _viewType = 'cert-viewer-${_certIframeCounter++}';
    _iframe = html.IFrameElement()
      ..src = _embedUrl
      ..allow = 'autoplay'
      ..style.cssText = 'border:none;width:100%;height:100%;';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int id) {
      return _iframe;
    });
  }

  void _close() {
    _iframe.src = 'about:blank';
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    final iframe = _iframe;
    iframe.src = 'about:blank';
    // Defer the DOM removal until after Flutter's close animation (~300ms).
    Future.delayed(const Duration(milliseconds: 400), iframe.remove);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1C1E1F) : Colors.white;
    final iframeBg = isDark ? const Color(0xFF282A2B) : const Color(0xFFD8D8D8);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 900,
          maxHeight: size.height * 0.88,
          minWidth: 340,
          minHeight: 420,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────
              Container(
                color: dialogBg,
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Institution icon
                    _InstitutionIcon(image: widget.image),
                    const Gap(14),
                    // Title + issuing entity
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorValues.textPrimary(context),
                              height: 1.3,
                            ),
                          ),
                          const Gap(3),
                          Text(
                            widget.issuingEntity,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorValues.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(14),
                    // Date chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorValues.bgChip(context),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ColorValues.borderChip(context)),
                      ),
                      child: Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorValues.textTertiary(context),
                        ),
                      ),
                    ),
                    const Gap(12),
                    // Close
                    GestureDetector(
                      onTap: _close,
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: ColorValues.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                height: 1,
                color: ColorValues.borderLine(context),
              ),

              // ── iframe (certificate preview) ─────────────────────────────
              Expanded(
                child: Container(
                  color: iframeBg,
                  child: HtmlElementView(
                    key: ValueKey(_viewType),
                    viewType: _viewType,
                  ),
                ),
              ),

              // Divider
              Container(
                height: 1,
                color: ColorValues.borderLine(context),
              ),

              // ── Footer ──────────────────────────────────────────────────
              Container(
                color: dialogBg,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  children: [
                    // Location badge (if available)
                    if (widget.location != null &&
                        widget.location!.isNotEmpty) ...[
                      Icon(
                        widget.location!.toLowerCase().contains('online')
                            ? Icons.language_rounded
                            : Icons.location_on_rounded,
                        size: 14,
                        color: const Color(0xFFE60000),
                      ),
                      const Gap(5),
                      Text(
                        widget.location!,
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorValues.textTertiary(context),
                        ),
                      ),
                    ] else
                      const Spacer(),
                    const Spacer(),
                    // Open in Drive button
                    _OpenDriveButton(url: widget.link),
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
// Institution icon — 40×40 rounded white box
// ─────────────────────────────────────────────────────────────────────────────

class _InstitutionIcon extends StatelessWidget {
  const _InstitutionIcon({this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorValues.borderSurface(context)),
        borderRadius: BorderRadius.circular(11),
      ),
      child: image != null
          ? Image.asset(image!, fit: BoxFit.cover)
          : Icon(
              Icons.workspace_premium_outlined,
              size: 22,
              color: Colors.grey.shade600,
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "Open in Drive" footer button
// ─────────────────────────────────────────────────────────────────────────────

class _OpenDriveButton extends StatefulWidget {
  const _OpenDriveButton({required this.url});
  final String url;

  @override
  State<_OpenDriveButton> createState() => _OpenDriveButtonState();
}

class _OpenDriveButtonState extends State<_OpenDriveButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.brandGreenSolid(context).withValues(alpha: 0.15)
                : ColorValues.bgChip(context),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? ColorValues.brandGreenSolid(context).withValues(alpha: 0.5)
                  : ColorValues.borderChip(context),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new_rounded,
                size: 15,
                color: ColorValues.brandGreenSolid(context),
              ),
              const Gap(7),
              Text(
                context.l10n.certModalOpenInDrive,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: ColorValues.brandGreenSolid(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
