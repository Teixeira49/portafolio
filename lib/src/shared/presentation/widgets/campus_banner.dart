import 'package:flutter/material.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/utils/asset_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/variables/constants/constants.dart';
import '../../../core/variables/values/values.dart';

// Mirrors .edu-degree: surface card with left tricolor accent bar, university
// logo, degree info and graduation badge.
class CampusBanner extends StatelessWidget {
  const CampusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorValues.bgSurface(context),
        border: Border.all(color: ColorValues.borderSurface(context)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 44,
            spreadRadius: -22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          // .edu-degree-accent — 5 px left bar with brand gradient
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: const BoxDecoration(gradient: GradientValues.brand),
            ),
          ),
          // Main content — left padding clears the accent bar
          Padding(
            padding: const EdgeInsets.fromLTRB(33, 24, 28, 24),
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _logo(context),
                _degreeInfo(context),
                _gradBadge(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // .edu-logo — 96×96 white rounded container with logo
  Widget _logo(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorValues.borderSurface(context)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(AssetImages.unimetBanner, fit: BoxFit.contain),
    );
  }

  // .edu-degree-info — title + university name + meta row
  Widget _degreeInfo(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 420),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.educationDegreeTitle,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: ColorValues.textPrimary(context),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.educationUniversityName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorValues.textSecondary(context),
            ),
          ),
          const SizedBox(height: 14),
          // .edu-degree-meta — location + website link
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _MetaLink(
                icon: Icons.location_on_outlined,
                label: context.l10n.locationLabel,
                url: 'https://maps.app.goo.gl/aKsNY7nuwBhozjaP9',
              ),
              _MetaLink(
                icon: Icons.language_outlined,
                label: context.l10n.visitWebsiteButtonLabel,
                url: Constants.campusWebsite,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // .edu-grad-badge — green tinted pill with mortarboard icon
  Widget _gradBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: ColorValues.bgGreenTint(context),
        border: Border.all(color: const Color(0x4D00E660)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school_outlined,
            size: 16,
            color: ColorValues.brandGreenSolid(context),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.educationGraduatedLabel,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: ColorValues.brandGreenSolid(context),
            ),
          ),
        ],
      ),
    );
  }
}

// .edu-meta-item.edu-link — clickable blue link
class _MetaLink extends StatefulWidget {
  const _MetaLink({required this.icon, required this.label, required this.url});

  final IconData icon;
  final String label;
  final String url;

  @override
  State<_MetaLink> createState() => _MetaLinkState();
}

class _MetaLinkState extends State<_MetaLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 17,
              color: ColorValues.brandBlueSolid(context),
            ),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorValues.brandBlueSolid(context),
                decoration: _hovered ? TextDecoration.underline : null,
                decorationColor: ColorValues.brandBlueSolid(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
