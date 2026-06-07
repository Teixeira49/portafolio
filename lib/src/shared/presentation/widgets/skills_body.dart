import 'package:flutter/material.dart';
import 'package:portafolio/src/shared/presentation/widgets/skills_card.dart';

// Mirrors the CSS .skill-grid: repeat(auto-fill, minmax(205px, 1fr))
// Column counts based on available width:
//   < 480 px  → 1 column
//   < 740 px  → 2 columns
//   ≥ 740 px  → 3 columns
const double _kGap = 12;

int _columns(double width) {
  if (width < 480) return 1;
  if (width < 740) return 2;
  return 3;
}

class SkillsBody extends StatelessWidget {
  const SkillsBody({super.key, required this.skills});

  final List<dynamic> skills;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _columns(constraints.maxWidth);
        final cardWidth =
            (constraints.maxWidth - (cols - 1) * _kGap) / cols;

        return Wrap(
          spacing: _kGap,
          runSpacing: _kGap,
          children: skills.map((s) {
            return SizedBox(
              width: cardWidth,
              child: SkillsCard(
                title: s['name'] as String,
                asset: s['image'] as String?,
                level: s['level'],
                color: s['color'] as Color?,
                isFavorite: s['isFavorite'] as bool? ?? false,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
