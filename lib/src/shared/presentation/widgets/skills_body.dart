import 'package:flutter/material.dart';
import 'package:portafolio/src/shared/presentation/widgets/skills_card.dart';
import '../../../core/variables/values/values.dart';

class SkillsBody extends StatelessWidget {
  const SkillsBody({super.key, required this.skills});

  final List<dynamic> skills;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: WidthValues.spacingSm,
      children: _buildSkills(context, skills),
    );
  }

  List<Widget> _buildSkills(BuildContext context, List<dynamic> skill) {
    final columnCount = _calculateResponsiveColumn(context) + 1;

    final rows = <List<dynamic>>[];
    for (var i = 0; i < skill.length; i += columnCount) {
      final end = (i + columnCount < skill.length) ? i + columnCount : skill.length;
      rows.add(skill.sublist(i, end));
    }

    return rows.map((rowSkills) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: WidthValues.spacingSm,
        children: rowSkills.map((skillBlock) {
          return Expanded(
            child: SkillsCard(
              title: skillBlock['name'],
              asset: skillBlock['image'],
              level: skillBlock['level'],
            ),
          );
        }).toList(),
      );
    }).toList();
  }

  int _calculateResponsiveColumn(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 850) {
      return 0;
    } else if (width < 1200) {
      return 1;
    } else if (width < 1400) {
      return 2;
    } else if (width < 1600) {
      return 3;
    } else if (width < 1900) {
      return 4;
    } else if (width < 2400) {
      return 5;
    } else {
      return 6;
    }
  }
}
