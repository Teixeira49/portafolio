import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/asset_images.dart';
import '../../../core/variables/values/values.dart';
import '../../../features/home/presentation/bloc/chat_bloc/bloc.dart';

const _kBrandGradientV = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF00E660), Color(0xFF1F55C4), Color(0xFFE60000)],
  stops: [0.0, 0.52, 1.0],
);

const _kBrandGradientH = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF00E660), Color(0xFF1F55C4), Color(0xFFE60000)],
  stops: [0.0, 0.52, 1.0],
);

class ResumeBody extends StatelessWidget {
  const ResumeBody({super.key, required this.aboutData});

  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 500;

        return Container(
          margin: const EdgeInsets.only(top: 18),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: ColorValues.bgSurface(context),
            border: Border.all(color: ColorValues.borderSurface(context)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x991A1A1A),
                blurRadius: 44,
                spreadRadius: -22,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Accent bar — 5 px gradient strip flush to the left edge
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 5,
                  decoration: const BoxDecoration(gradient: _kBrandGradientV),
                ),
              ),

              // Main content (30 px left pad = 5 accent + 25 gap)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 22, 26, 22),
                child: isWide ? _WideLayout(aboutData: aboutData) : _NarrowLayout(aboutData: aboutData),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Wide layout (≥ 500 px): left info | divider | stats ─────────────────────

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.aboutData});
  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _IdLeft(aboutData: aboutData)),
        const Gap(28),
        // Fixed-height divider avoids IntrinsicHeight + Expanded conflicts
        Container(
          width: 2,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: _kBrandGradientV,
          ),
        ),
        const Gap(28),
        _IdStats(aboutData: aboutData),
      ],
    );
  }
}

// ─── Narrow layout (< 500 px): stacked ───────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.aboutData});
  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _IdLeft(aboutData: aboutData),
        const Gap(18),
        Container(
          height: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: _kBrandGradientH,
          ),
        ),
        const Gap(18),
        _IdStats(aboutData: aboutData),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Left section: avatar + name / role / location
// ─────────────────────────────────────────────────────────────────────────────

class _IdLeft extends StatelessWidget {
  const _IdLeft({required this.aboutData});
  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _IdAvatar(),
        const Gap(18),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                aboutData['name'].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: ColorValues.textPrimary(context),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                context.l10n.resumeTitleLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: ColorValues.textSecondary(context),
                ),
              ),
              const SizedBox(height: 7),
              _IdLocation(
                location: aboutData['location'].toString(),
                link: aboutData['location_link'].toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Avatar: 74 × 74 gradient circle, green ring, "JT" initials
// ─────────────────────────────────────────────────────────────────────────────

class _IdAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(AssetImages.profile),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(color: Color(0xFF00E660), blurRadius: 0, spreadRadius: 2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Location row with red pin icon
// ─────────────────────────────────────────────────────────────────────────────

class _IdLocation extends StatefulWidget {
  const _IdLocation({required this.location, required this.link});
  final String location;
  final String link;

  @override
  State<_IdLocation> createState() => _IdLocationState();
}

// Fallback Google Maps URL for Caracas when no env link is provided.
const String _kCaracasMapsUrl =
    'https://maps.google.com/?q=Caracas,+Venezuela';

class _IdLocationState extends State<_IdLocation> {
  bool _hovered = false;

  String get _resolvedUrl =>
      widget.link.isNotEmpty ? widget.link : _kCaracasMapsUrl;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(_resolvedUrl),
          mode: LaunchMode.externalApplication,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, size: 16, color: Color(0xFFE60000)),
            const Gap(6),
            Flexible(
              child: Text(
                widget.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: _hovered
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

// ─────────────────────────────────────────────────────────────────────────────
// Stats: years of experience (green) + projects completed (blue)
// ─────────────────────────────────────────────────────────────────────────────

class _IdStats extends StatelessWidget {
  const _IdStats({required this.aboutData});
  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    final years =
        (DateTime.now().year - (aboutData['years'] as int)).toString();
    final projects = aboutData['projects'].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StatRow(
          value: years,
          label: context.l10n.resumeYearsCompleteLabel,
          valueColor: const Color(0xFF00E660),
          onTap: () => context
              .read<ChatBloc>()
              .add(GetChatMessages('experience_chat')),
        ),
        const Gap(14),
        _StatRow(
          value: projects,
          label: context.l10n.resumeProjectsCompleteLabel,
          valueColor: const Color(0xFF1F55C4),
          onTap: () => context
              .read<ChatBloc>()
              .add(GetChatMessages('projects_chat')),
        ),
      ],
    );
  }
}

class _StatRow extends StatefulWidget {
  const _StatRow({
    required this.value,
    required this.label,
    required this.valueColor,
    required this.onTap,
  });

  final String value;
  final String label;
  final Color valueColor;
  final VoidCallback onTap;

  @override
  State<_StatRow> createState() => _StatRowState();
}

class _StatRowState extends State<_StatRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.value,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                height: 1,
                color: _hovered
                    ? widget.valueColor.withValues(alpha: 0.75)
                    : widget.valueColor,
              ),
            ),
            const Gap(13),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 15,
                color: ColorValues.textSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
