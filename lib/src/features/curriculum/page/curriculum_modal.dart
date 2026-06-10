// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/values/values.dart';

// ── PDF URL table ─────────────────────────────────────────────────────────────
// TODO: Replace the four placeholder URLs with your actual hosted PDF links.
//   _kPdfUrls[language]![showPhoto] → PDF URL
//
//   'es' + true  → Spanish CV with profile photo
//   'es' + false → Spanish CV without profile photo
//   'en' + true  → English CV with profile photo
//   'en' + false → English CV without profile photo
// ─────────────────────────────────────────────────────────────────────────────
const _kPdfUrls = {
  'es': {
    true:  'https://example.com/cv_es_foto.pdf',    // TODO: replace
    false: 'https://example.com/cv_es_sinfoto.pdf', // TODO: replace
  },
  'en': {
    true:  'https://example.com/cv_en_foto.pdf',    // TODO: replace
    false: 'https://example.com/cv_en_sinfoto.pdf', // TODO: replace
  },
};

String _urlFor(String language, bool showPhoto) =>
    _kPdfUrls[language]![showPhoto]!;

// ── Unique view-type counter ──────────────────────────────────────────────────
// Each PDF URL needs its own registered factory — re-using a key registered
// with a different src is not allowed, so we bump this counter on every
// selection change to produce a fresh, never-used viewType key.
int _cvIframeCounter = 0;

// ─────────────────────────────────────────────────────────────────────────────

class CurriculumDialog extends StatefulWidget {
  const CurriculumDialog({super.key});

  @override
  State<CurriculumDialog> createState() => _CurriculumDialogState();
}

class _CurriculumDialogState extends State<CurriculumDialog> {
  String _language = 'es';
  bool _showPhoto = true;
  late String _viewType;

  @override
  void initState() {
    super.initState();
    _registerIframe();
  }

  String get _currentUrl => _urlFor(_language, _showPhoto);

  void _registerIframe() {
    _viewType = 'cv-pdf-viewer-${_cvIframeCounter++}';
    final url = _currentUrl;
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int id) {
      return html.IFrameElement()
        ..src = url
        ..style.cssText = 'border:none;width:100%;height:100%;';
    });
  }

  void _setLanguage(String lang) {
    if (_language == lang) return;
    setState(() {
      _language = lang;
      _registerIframe();
    });
  }

  void _setShowPhoto(bool value) {
    if (_showPhoto == value) return;
    setState(() {
      _showPhoto = value;
      _registerIframe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1060,
          maxHeight: size.height * 0.88,
          minHeight: 400,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Row(
            children: [
              // ── Left: PDF preview ─────────────────────────────────────────
              Expanded(
                flex: 5,
                child: Container(
                  color: isDark
                      ? const Color(0xFF282A2B)
                      : const Color(0xFFD8D8D8),
                  child: HtmlElementView(
                    key: ValueKey(_viewType),
                    viewType: _viewType,
                  ),
                ),
              ),
              // ── Right: Controls panel ─────────────────────────────────────
              SizedBox(
                width: 268,
                child: _ControlsPanel(
                  language: _language,
                  showPhoto: _showPhoto,
                  downloadUrl: _currentUrl,
                  onLanguageChanged: _setLanguage,
                  onShowPhotoChanged: _setShowPhoto,
                  onClose: () => Navigator.of(context).pop(),
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
// Controls panel (right column)
// ─────────────────────────────────────────────────────────────────────────────

class _ControlsPanel extends StatelessWidget {
  const _ControlsPanel({
    required this.language,
    required this.showPhoto,
    required this.downloadUrl,
    required this.onLanguageChanged,
    required this.onShowPhotoChanged,
    required this.onClose,
  });

  final String language;
  final bool showPhoto;
  final String downloadUrl;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onShowPhotoChanged;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelBg = isDark ? const Color(0xFF1C1E1F) : Colors.white;

    return Container(
      color: panelBg,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + close button
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.cvModalTitle,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: ColorValues.textPrimary(context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: ColorValues.textSecondary(context),
                ),
              ),
            ],
          ),
          const Gap(6),
          Text(
            context.l10n.cvModalSubtitle,
            style: TextStyle(
              fontSize: 13,
              color: ColorValues.textSecondary(context),
              height: 1.4,
            ),
          ),
          const Gap(24),

          // IDIOMA section
          _SectionLabel(label: context.l10n.cvModalLanguageSection),
          const Gap(10),
          _LanguageToggle(
            selected: language,
            onSelect: onLanguageChanged,
          ),
          const Gap(22),

          // FOTO section
          _SectionLabel(label: context.l10n.cvModalPhotoSection),
          const Gap(10),
          _PhotoToggleCard(
            showPhoto: showPhoto,
            onChanged: onShowPhotoChanged,
          ),

          const Spacer(),

          // Status line
          Row(
            children: [
              Icon(
                Icons.check_rounded,
                size: 13,
                color: ColorValues.textTertiary(context),
              ),
              const Gap(5),
              Expanded(
                child: Text(
                  _buildStatusText(context),
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorValues.textTertiary(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(14),

          // Download button
          _DownloadButton(url: downloadUrl),
        ],
      ),
    );
  }

  String _buildStatusText(BuildContext context) {
    final langLabel = language == 'es'
        ? context.l10n.languageSpanishLabel
        : context.l10n.languageEnglishLabel;
    final photoLabel = showPhoto
        ? context.l10n.cvModalWithPhotoLabel
        : context.l10n.cvModalWithoutPhotoLabel;
    return '${context.l10n.cvModalStatusPrefix} $langLabel · $photoLabel';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section label — e.g. "IDIOMA", "FOTO"
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: ColorValues.textTertiary(context),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Language segmented toggle — [Español] [Inglés]
// ─────────────────────────────────────────────────────────────────────────────

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({required this.selected, required this.onSelect});
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackBg = isDark ? const Color(0xFF2A2C2D) : const Color(0xFFF0F0F0);

    return Container(
      decoration: BoxDecoration(
        color: trackBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _ToggleOption(
            label: context.l10n.languageSpanishLabel,
            id: 'es',
            selected: selected,
            onSelect: onSelect,
          ),
          const Gap(4),
          _ToggleOption(
            label: context.l10n.languageEnglishLabel,
            id: 'en',
            selected: selected,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.id,
    required this.selected,
    required this.onSelect,
  });

  final String label;
  final String id;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == id;

    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF00E660)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF0D1A12)
                    : ColorValues.textSecondary(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Photo toggle card
// ─────────────────────────────────────────────────────────────────────────────

class _PhotoToggleCard extends StatelessWidget {
  const _PhotoToggleCard({
    required this.showPhoto,
    required this.onChanged,
  });

  final bool showPhoto;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF252728) : const Color(0xFFF5F5F5);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.cvModalShowPhotoLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorValues.textPrimary(context),
                  ),
                ),
                const Gap(2),
                Text(
                  context.l10n.cvModalShowPhotoSubtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorValues.textTertiary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: showPhoto,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF00E660),
            activeTrackColor: const Color(0xFF00E660).withValues(alpha: 0.35),
            inactiveThumbColor: ColorValues.textTertiary(context),
            inactiveTrackColor: ColorValues.borderLine(context),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Download PDF button
// ─────────────────────────────────────────────────────────────────────────────

class _DownloadButton extends StatefulWidget {
  const _DownloadButton({required this.url});
  final String url;

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF1F55C4).withValues(alpha: 0.85)
                : const Color(0xFF1F55C4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 18,
              ),
              const Gap(9),
              Text(
                context.l10n.cvModalDownloadButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
