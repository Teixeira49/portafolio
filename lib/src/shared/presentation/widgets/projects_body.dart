
import 'package:flutter/material.dart';
import 'package:portafolio/src/shared/presentation/widgets/projects_card.dart';

import '../../../core/variables/values/values.dart';

class ProjectsBody extends StatelessWidget {
  const ProjectsBody({super.key, required this.projects});

  final List<dynamic> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: WidthValues.spacingSm,
      children: _buildProjects(context, projects),
    );
  }

  List<Widget> _buildProjects(BuildContext context, List<dynamic> project) {
    final columnCount = _calculateResponsiveColumn(context) + 1;
    final rows = <List<dynamic>>[];
    for (var i = 0; i < project.length; i += columnCount) {
      final end = (i + columnCount < project.length) ? i + columnCount : project.length;
      rows.add(project.sublist(i, end));
    }

    return rows.map((rowProject) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: WidthValues.spacingSm,
        children: rowProject.map((skillBlock) {
          return Expanded(
            child: ProjectCard(
              name: skillBlock['name'],
              initDate: skillBlock['init_time'],
              endDate: skillBlock['end_time'],
              technologies: skillBlock['technologies'],
              repository: skillBlock['repository'],
              prototype: skillBlock['prototype'],
              link: skillBlock['link'],
              description: skillBlock['description'],
              private: skillBlock['private'],
            ),
          );
        }).toList(),
      );
    }).toList();
  }

  int _calculateResponsiveColumn(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 1200) {
      return 0;
    }
    else if (width < 1600) {
      return 1;
    }
    else if (width < 2000) {
      return 2;
    } else {
      return 3;
    }
  }
}
