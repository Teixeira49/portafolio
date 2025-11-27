
import 'package:flutter/material.dart';

import '../../../core/variables/values/values.dart';
import 'certifications_cards.dart';

class CertificationsBody extends StatelessWidget {
  const CertificationsBody({super.key, required this.certifications});

  final List<dynamic> certifications;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: WidthValues.spacingSm,
      children: _buildCertifications(context, certifications),
    );
  }

  List<Widget> _buildCertifications(BuildContext context, List<dynamic> project) {
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
            child: CertificationsCard(
              title: skillBlock['title'],
              issuingEntity: skillBlock['issuing_entity'],
              location: skillBlock['location'],
              date: skillBlock['date'],
              link: skillBlock['link'],
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
