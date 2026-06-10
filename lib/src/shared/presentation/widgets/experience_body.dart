import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';
import 'package:portafolio/src/core/utils/helpers.dart';
import 'package:portafolio/src/core/variables/values/values.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ── Graph visual constants ────────────────────────────────────────────────────

const double _kGraphWidth = 62.0;
const double _kCol0X = 13.0; // trunk (green)
const double _kCol1X = 29.0; // blue branch
const double _kCol2X = 45.0; // red branch
const double _kNodeR = 5.5;
const double _kLineW = 1.8;
const double _kNodeBorderW = 2.0;
const double _kRowPadV = 5.0;

// ── Row type ──────────────────────────────────────────────────────────────────

// trunk = col0 (green), branch = col1 (blue), red = col2 (red), label = no node
enum _RowType { trunk, branch, red, label }

// ── Row config ────────────────────────────────────────────────────────────────

class _RowCfg {
  const _RowCfg({
    required this.type,
    required this.trunkTop,
    required this.trunkBot,
    required this.branchTop,   // col1 blue
    required this.branchBot,
    this.redTop = false,        // col2 red
    this.redBot = false,
    required this.divergeBot,
    required this.mergeTop,     // col1 → col0 curve in top half
    this.mergeTopRed = false,   // col2 → col0 curve in top half (red merges at Flembee)
    this.mergeBotRed = false,   // col2 → col0 curve in bottom half (red closes into Estei from below)
  });

  final _RowType type;
  final bool trunkTop, trunkBot;
  final bool branchTop, branchBot;
  final bool redTop, redBot;
  final bool divergeBot;
  final bool mergeTop;
  final bool mergeTopRed;
  final bool mergeBotRed;
}

// ── Branch topology ───────────────────────────────────────────────────────────
//
// Visual order = strict start-date descending (newest at top).
// Three columns are active during the parallel period:
//   col0 (green/trunk) – continuous career line
//   col1 (blue)        – Banking Tech + Desafío S7B
//   col2 (red)         – Reto Inspira VE (single item; parallel w/ Flembee & Banking)
//
//   visual[0]  data[0]  Estei Turismo (04/2026–)            TRUNK (green) – starts where Flembee ends
//   visual[1]  data[1]  Reto Inspira VE (03/2026–05/2026)   RED col2 – node only, no line above
//   visual[2]  data[2]  Banking Tech (12/2025–)             BLUE col1
//   visual[3]  data[3]  Desafío S7B (06/2025–10/2025)       BLUE col1
//   visual[4]  label    "En paralelo — dentro de..."
//   visual[5]  data[4]  Flembee (04/2025–04/2026)           TRUNK – MERGES blue + red
//   visual[6]  data[5]  JM Rios (03/2024–03/2025)           trunk
//   visual[7]  data[6]  En la Parada (06/2023–12/2023)      trunk
//   visual[8]  data[7]  Self-Learning (01/2023–)            trunk (last)

const List<_RowCfg> _kCfg = [
  // 0 Estei – TRUNK green; green + blue exit the top (both ongoing today).
  //   Red closes here via mergeBotRed (Reto Inspira merges into trunk at this node).
  _RowCfg(type: _RowType.trunk,  trunkTop: true,  trunkBot: true,  branchTop: true,  branchBot: true,  redTop: false, redBot: false, divergeBot: false, mergeTop: false, mergeBotRed: true),
  // 1 Reto Inspira VE – RED; red goes UP (to Estei merge) AND DOWN (to Flembee merge).
  _RowCfg(type: _RowType.red,    trunkTop: true,  trunkBot: true,  branchTop: true,  branchBot: true,  redTop: true,  redBot: true,  divergeBot: false, mergeTop: false),
  // 2 Banking Tech – BLUE; trunk passes, blue node; red passes through.
  _RowCfg(type: _RowType.branch, trunkTop: true,  trunkBot: true,  branchTop: true,  branchBot: true,  redTop: true,  redBot: true,  divergeBot: false, mergeTop: false),
  // 3 Desafío S7B – BLUE; trunk passes, blue node; red passes through.
  _RowCfg(type: _RowType.branch, trunkTop: true,  trunkBot: true,  branchTop: true,  branchBot: true,  redTop: true,  redBot: true,  divergeBot: false, mergeTop: false),
  // 4 Parallel label – trunk + blue + red pass through.
  _RowCfg(type: _RowType.label,  trunkTop: true,  trunkBot: true,  branchTop: true,  branchBot: true,  redTop: true,  redBot: true,  divergeBot: false, mergeTop: false),
  // 5 Flembee – TRUNK; MERGES blue (mergeTop) AND red (mergeTopRed) from above.
  _RowCfg(type: _RowType.trunk,  trunkTop: true,  trunkBot: true,  branchTop: false, branchBot: false, redTop: false, redBot: false, divergeBot: false, mergeTop: true, mergeTopRed: true),
  // 6 JM Rios – trunk
  _RowCfg(type: _RowType.trunk,  trunkTop: true,  trunkBot: true,  branchTop: false, branchBot: false, divergeBot: false, mergeTop: false),
  // 7 En la Parada – trunk
  _RowCfg(type: _RowType.trunk,  trunkTop: true,  trunkBot: true,  branchTop: false, branchBot: false, divergeBot: false, mergeTop: false),
  // 8 Self-Learning – trunk last
  _RowCfg(type: _RowType.trunk,  trunkTop: true,  trunkBot: false, branchTop: false, branchBot: false, divergeBot: false, mergeTop: false),
];

// data index for each visual row (-1 = label row, no data)
const List<int> _kDataIndex = [0, 1, 2, 3, -1, 4, 5, 6, 7];

// ── Public widget ─────────────────────────────────────────────────────────────

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.experience});

  final List<Map<String, dynamic>> experience;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trunkColor =
        isDark ? const Color(0xFF3EF08A) : const Color(0xFF0A8F43);
    final branchColor =
        isDark ? const Color(0xFF7FA8FF) : const Color(0xFF2554C4);
    final redColor =
        isDark ? const Color(0xFFFF7A7A) : const Color(0xFFC41F1F);
    final bgColor = ColorValues.bgSurface(context);

    // The parallel label references Flembee (data[4]).
    final trunkItem = experience[4];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth - _kGraphWidth - 16.0).clamp(180.0, double.infinity);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < _kCfg.length; i++)
              if (_kCfg[i].type == _RowType.label)
                _LabelRow(
                  cfg: _kCfg[i],
                  trunkColor: trunkColor,
                  branchColor: branchColor,
                  redColor: redColor,
                  trunkItem: trunkItem,
                )
              else
                _GraphRow(
                  item: experience[_kDataIndex[i]],
                  cfg: _kCfg[i],
                  trunkColor: trunkColor,
                  branchColor: branchColor,
                  redColor: redColor,
                  bgColor: bgColor,
                  cardWidth: cardWidth,
                ),
          ],
        );
      },
    );
  }
}

// ── Label row (parallel context) ──────────────────────────────────────────────

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.cfg,
    required this.trunkColor,
    required this.branchColor,
    required this.redColor,
    required this.trunkItem,
  });

  final _RowCfg cfg;
  final Color trunkColor, branchColor, redColor;
  final Map<String, dynamic> trunkItem;

  @override
  Widget build(BuildContext context) {
    final isEs = Localizations.localeOf(context).languageCode == 'es';
    final prefix = isEs ? 'En paralelo — dentro de' : 'In parallel — within';

    final initStr =
        Helpers.getParsedDate(context, trunkItem['init_time'] as String, shortMonth: true);
    final endRaw = trunkItem['end_time'];
    final endStr = (endRaw == null || (endRaw as String).isEmpty)
        ? context.l10n.projectActualDateLabel
        : Helpers.getParsedDate(context, endRaw, shortMonth: true);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _kGraphWidth,
            child: CustomPaint(
              painter: _LabelPainter(
                trunkColor: trunkColor,
                branchColor: branchColor,
                redColor: redColor,
              ),
            ),
          ),
          const Gap(16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$prefix $initStr – $endStr',
                  style: ExtendedTextTheme.textExtraSmall(context).copyWith(
                    color: ColorValues.textTertiary(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Graph row (trunk or branch) ───────────────────────────────────────────────

class _GraphRow extends StatelessWidget {
  const _GraphRow({
    required this.item,
    required this.cfg,
    required this.trunkColor,
    required this.branchColor,
    required this.redColor,
    required this.bgColor,
    required this.cardWidth,
  });

  final Map<String, dynamic> item;
  final _RowCfg cfg;
  final Color trunkColor, branchColor, redColor, bgColor;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    final nodeColor = switch (cfg.type) {
      _RowType.trunk  => trunkColor,
      _RowType.branch => branchColor,
      _RowType.red    => redColor,
      _RowType.label  => Colors.transparent,
    };
    final isBranch = cfg.type != _RowType.trunk;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _kGraphWidth,
            child: CustomPaint(
              painter: _RowPainter(
                cfg: cfg,
                trunkColor: trunkColor,
                branchColor: branchColor,
                redColor: redColor,
                bgColor: bgColor,
                nodeColor: nodeColor,
              ),
            ),
          ),
          const Gap(16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: _kRowPadV),
              child: _ExperienceCard(
                item: item,
                isBranch: isBranch,
                accentColor: nodeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Experience card ───────────────────────────────────────────────────────────

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.item,
    required this.isBranch,
    required this.accentColor,
  });

  final Map<String, dynamic> item;
  final bool isBranch;
  final Color accentColor;

  // Normalises single-company and multi-company entries into one list.
  List<({String name, String? url, String? image})> _companies() {
    if (item['companies'] != null) {
      return (item['companies'] as List)
          .cast<Map<String, dynamic>>()
          .map((c) => (name: c['name'] as String, url: c['url'] as String?, image: c['image'] as String?))
          .toList();
    }
    return [(
      name: item['company'] as String,
      url: item['company_url'] as String?,
      image: item['image'] as String?,
    )];
  }

  String _localizedDesc(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final desc = item['description'] as Map<String, dynamic>;
    return (desc[locale] ?? desc['en'] ?? '').toString();
  }

  String _buildDateStr(BuildContext context) {
    final init = item['init_time'] as String;
    final endRaw = item['end_time'];
    final initStr = Helpers.getParsedDate(context, init, shortMonth: true);
    if (endRaw == null || (endRaw as String).isEmpty) {
      return '$initStr – ${context.l10n.projectActualDateLabel}';
    }
    return '$initStr – ${Helpers.getParsedDate(context, endRaw, shortMonth: true)}';
  }

  @override
  Widget build(BuildContext context) {
    final companies = _companies();
    final primaryName = companies.first.name;
    final primaryImage = companies.first.image;
    final role = item['role'] as String?;
    final event = item['event'] as String?;
    final eventUrls = item['event_urls'] == null
        ? null
        : (item['event_urls'] as List).cast<String>();
    final isHackathon = (item['category'] as String?) == 'Hackathon';
    final dateStr = _buildDateStr(context);
    final dateColor = accentColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WidthValues.radiusLg),
        color: ColorValues.bgSurface(context),
        border: Border.all(color: ColorValues.borderSurface(context)),
      ),
      padding: EdgeInsets.all(WidthValues.spacingMd + WidthValues.spacingXs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo: initial of the primary (first) company or image
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(WidthValues.radiusSm),
                  color: ColorValues.bgChip(context),
                  border: primaryImage == null ? Border.all(color: ColorValues.borderSurface(context)) : null,
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: primaryImage != null
                      ? Image.asset(primaryImage, fit: BoxFit.cover, width: 44, height: 44)
                      : Text(
                          primaryName[0].toUpperCase(),
                          style: ExtendedTextTheme.titleMedium(context)
                              .copyWith(color: accentColor),
                        ),
                ),
              ),
              Gap(WidthValues.spacingXs),
              // Company name(s) + optional subtitle
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company name(s) row + hackathon badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _CompanyNamesRow(
                            companies: companies,
                            accentColor: accentColor,
                            context: context,
                          ),
                        ),
                        if (isHackathon) ...[
                          Gap(WidthValues.spacingXxs),
                          _HackathonBadge(color: accentColor),
                        ],
                      ],
                    ),
                    // Subtitle: role (jobs) or event name (hackathons)
                    if (role != null && role.isNotEmpty) ...[
                      Gap(WidthValues.spacingXxs),
                      Text(
                        role,
                        style: ExtendedTextTheme.textSmall(context).copyWith(
                          color: ColorValues.textTertiary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ] else if (event != null) ...[
                      Gap(WidthValues.spacingXxs),
                      _EventSubtitle(
                        event: event,
                        urls: eventUrls,
                        accentColor: accentColor,
                        context: context,
                      ),
                    ],
                  ],
                ),
              ),
              Gap(WidthValues.spacingXs),
              // Date
              Text(
                dateStr,
                style: ExtendedTextTheme.textSmall(context).copyWith(
                  color: dateColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .2,
                ),
              ),
            ],
          ),
          // ── Description ─────────────────────────────────────────────────
          Gap(WidthValues.spacingXs),
          Text(
            _localizedDesc(context),
            style: ExtendedTextTheme.textSmall(context).copyWith(
              color: ColorValues.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Company names row ─────────────────────────────────────────────────────────
// Renders one or more company names separated by " · ", each optionally linkable.

class _CompanyNamesRow extends StatelessWidget {
  const _CompanyNamesRow({
    required this.companies,
    required this.accentColor,
    required this.context,
  });

  final List<({String name, String? url, String? image})> companies;
  final Color accentColor;
  final BuildContext context;

  @override
  Widget build(_) {
    if (companies.length == 1) {
      return _CompanyLink(
        name: companies[0].name,
        url: companies[0].url,
        accentColor: accentColor,
        context: context,
      );
    }
    // Multiple companies: "EY Venezuela [↗] · Kurius [↗]"
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < companies.length; i++) ...[
          _CompanyLink(
            name: companies[i].name,
            url: companies[i].url,
            accentColor: accentColor,
            context: context,
          ),
          if (i < companies.length - 1)
            Text(
              ' · ',
              style: ExtendedTextTheme.titleMedium(context).copyWith(
                color: ColorValues.textTertiary(context),
              ),
            ),
        ],
      ],
    );
  }
}

// ── Single linkable company name ──────────────────────────────────────────────

class _CompanyLink extends StatelessWidget {
  const _CompanyLink({
    required this.name,
    required this.url,
    required this.accentColor,
    required this.context,
  });

  final String name;
  final String? url;
  final Color accentColor;
  final BuildContext context;

  @override
  Widget build(_) {
    final hasUrl = url != null && url!.isNotEmpty;
    final nameStyle = ExtendedTextTheme.titleMedium(context).copyWith(
      color: hasUrl ? accentColor : null,
    );

    if (!hasUrl) {
      return Text(name, style: nameStyle, maxLines: 1, overflow: TextOverflow.ellipsis);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openUrl(url!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(name, style: nameStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            const Gap(3),
            Icon(Icons.open_in_new_rounded, size: 12, color: accentColor.withAlpha(160)),
          ],
        ),
      ),
    );
  }
}

// ── Event subtitle (hackathons) ───────────────────────────────────────────────
// Shows the competition name followed by one link icon per event URL.

class _EventSubtitle extends StatelessWidget {
  const _EventSubtitle({
    required this.event,
    required this.urls,
    required this.accentColor,
    required this.context,
  });

  final String event;
  final List<String>? urls;
  final Color accentColor;
  final BuildContext context;

  @override
  Widget build(_) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            event,
            style: ExtendedTextTheme.textSmall(context).copyWith(
              color: ColorValues.textTertiary(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (urls != null)
          for (final url in urls!)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _openUrl(url),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.open_in_new_rounded,
                    size: 11,
                    color: accentColor.withAlpha(160),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

// ── Hackathon badge ───────────────────────────────────────────────────────────

class _HackathonBadge extends StatelessWidget {
  const _HackathonBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        'Hackathon',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.8,
          height: 1.3,
        ),
      ),
    );
  }
}

// ── Label painter ─────────────────────────────────────────────────────────────

class _LabelPainter extends CustomPainter {
  const _LabelPainter({
    required this.trunkColor,
    required this.branchColor,
    required this.redColor,
  });

  final Color trunkColor, branchColor, redColor;

  @override
  void paint(Canvas canvas, Size size) {
    final mid = size.height / 2;

    Paint stroke(Color c) => Paint()
      ..color = c
      ..strokeWidth = _kLineW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(_kCol0X, 0), Offset(_kCol0X, size.height), stroke(trunkColor));
    canvas.drawLine(Offset(_kCol1X, 0), Offset(_kCol1X, size.height), stroke(branchColor));
    canvas.drawLine(Offset(_kCol2X, 0), Offset(_kCol2X, size.height), stroke(redColor));

    // Subtle horizontal indicator: col0 → col1
    canvas.drawLine(
      Offset(_kCol0X + 2, mid),
      Offset(_kCol1X, mid),
      stroke(branchColor.withAlpha(120)),
    );
  }

  @override
  bool shouldRepaint(_LabelPainter old) =>
      old.trunkColor != trunkColor ||
      old.branchColor != branchColor ||
      old.redColor != redColor;
}

// ── Row painter ───────────────────────────────────────────────────────────────

class _RowPainter extends CustomPainter {
  const _RowPainter({
    required this.cfg,
    required this.trunkColor,
    required this.branchColor,
    required this.redColor,
    required this.bgColor,
    required this.nodeColor,
  });

  final _RowCfg cfg;
  final Color trunkColor, branchColor, redColor, bgColor, nodeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final mid = size.height / 2;
    final isTrunk  = cfg.type == _RowType.trunk;
    final isBlue   = cfg.type == _RowType.branch;
    final isRed    = cfg.type == _RowType.red;

    final nodeX = isTrunk ? _kCol0X : isBlue ? _kCol1X : _kCol2X;

    Paint stroke(Color c) => Paint()
      ..color = c
      ..strokeWidth = _kLineW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // ── col0 trunk line ───────────────────────────────────────────────────
    if (cfg.trunkTop) {
      final stopY = isTrunk ? mid - _kNodeR : mid;
      canvas.drawLine(Offset(_kCol0X, 0), Offset(_kCol0X, stopY), stroke(trunkColor));
    }
    if (cfg.trunkBot) {
      final startY = isTrunk ? mid + _kNodeR : mid;
      canvas.drawLine(Offset(_kCol0X, startY), Offset(_kCol0X, size.height), stroke(trunkColor));
    }

    // ── col1 blue branch line ─────────────────────────────────────────────
    if (cfg.branchTop) {
      final stopY = isBlue ? mid - _kNodeR : mid;
      canvas.drawLine(Offset(_kCol1X, 0), Offset(_kCol1X, stopY), stroke(branchColor));
    }
    if (cfg.branchBot) {
      final startY = isBlue ? mid + _kNodeR : mid;
      canvas.drawLine(Offset(_kCol1X, startY), Offset(_kCol1X, size.height), stroke(branchColor));
    }

    // ── col2 red branch line ──────────────────────────────────────────────
    if (cfg.redTop) {
      final stopY = isRed ? mid - _kNodeR : mid;
      canvas.drawLine(Offset(_kCol2X, 0), Offset(_kCol2X, stopY), stroke(redColor));
    }
    if (cfg.redBot) {
      final startY = isRed ? mid + _kNodeR : mid;
      canvas.drawLine(Offset(_kCol2X, startY), Offset(_kCol2X, size.height), stroke(redColor));
    }

    // ── Diverge bezier: col0 → col1 (bottom half, legacy) ────────────────
    if (cfg.divergeBot) {
      final half = size.height - mid;
      final path = Path()
        ..moveTo(_kCol0X, mid + _kNodeR)
        ..cubicTo(_kCol0X, mid + half * 0.65, _kCol1X, mid + half * 0.35, _kCol1X, size.height);
      canvas.drawPath(path, stroke(branchColor));
    }

    // ── Merge bezier: col1 → col0 (top half) ─────────────────────────────
    if (cfg.mergeTop) {
      final path = Path()
        ..moveTo(_kCol1X, 0)
        ..cubicTo(_kCol1X, mid * 0.35, _kCol0X, mid * 0.65, _kCol0X, mid - _kNodeR);
      canvas.drawPath(path, stroke(branchColor));
    }

    // ── Merge bezier: col2 → col0 (top half) — red merges at Flembee
    if (cfg.mergeTopRed) {
      final path = Path()
        ..moveTo(_kCol2X, 0)
        ..cubicTo(_kCol2X, mid * 0.35, _kCol0X, mid * 0.65, _kCol0X, mid - _kNodeR);
      canvas.drawPath(path, stroke(redColor));
    }

    // ── Merge bezier: col2 → col0 (bottom half) — red closes into Estei from below
    if (cfg.mergeBotRed) {
      final half = size.height - mid;
      final path = Path()
        ..moveTo(_kCol2X, size.height)
        ..cubicTo(_kCol2X, size.height - half * 0.35, _kCol0X, size.height - half * 0.65, _kCol0X, mid + _kNodeR);
      canvas.drawPath(path, stroke(redColor));
    }

    // ── Node circle ───────────────────────────────────────────────────────
    if (cfg.type == _RowType.label) return;

    if (isTrunk) {
      // Solid filled green circle
      canvas.drawCircle(Offset(nodeX, mid), _kNodeR,
          Paint()..color = nodeColor..style = PaintingStyle.fill);
    } else {
      // Blue or red branch: surface fill + colored outline
      canvas.drawCircle(Offset(nodeX, mid), _kNodeR,
          Paint()..color = bgColor..style = PaintingStyle.fill);
      canvas.drawCircle(Offset(nodeX, mid), _kNodeR,
          Paint()..color = nodeColor..strokeWidth = _kNodeBorderW..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(_RowPainter old) =>
      old.trunkColor != trunkColor ||
      old.branchColor != branchColor ||
      old.redColor != redColor ||
      old.bgColor != bgColor ||
      old.nodeColor != nodeColor;
}
