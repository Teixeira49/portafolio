import 'package:flutter/material.dart';

import '../../../core/variables/variables.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({
    super.key,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.maxWidth = 800,
    required this.children,
  });

  final String title;
  final List<Widget> children;
  final double maxWidth;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: 1250.0,
        minWidth: 300,
        minHeight: 300,
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        ),
        child: Padding(
          padding: EdgeInsets.all(WidthValues.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            spacing: WidthValues.padding,
            children: [
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  title,
                  style: ExtendedTextTheme.titleMedium(context),
                ),
              ),
              Divider(),
              ...children,
            ],
          ),
        ),
      ),
    ),
  );
}
