import 'package:flutter/material.dart';

import 'certifications_cards.dart';

// Mirrors .cert-grid: repeat(auto-fill, minmax(310px, 1fr)), gap: 14px
const double _kMinCardWidth = 310;
const double _kGap = 14;

class CertificationsBody extends StatelessWidget {
  const CertificationsBody({super.key, required this.certifications});

  final List<dynamic> certifications;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = (constraints.maxWidth / (_kMinCardWidth + _kGap))
            .floor()
            .clamp(1, certifications.length);
        final cardWidth =
            (constraints.maxWidth - (cols - 1) * _kGap) / cols;

        return Wrap(
          spacing: _kGap,
          runSpacing: _kGap,
          children: certifications.map((cert) {
            return SizedBox(
              width: cardWidth,
              child: CertificationsCard(
                title: cert['title'] as String,
                issuingEntity: cert['issuing_entity'] as String,
                date: cert['date'] as String,
                link: cert['link'] as String,
                image: cert['image'] as String?,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
