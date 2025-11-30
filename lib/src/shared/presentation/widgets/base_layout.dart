// main_layout_page.dart

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/variables/values/values.dart';
import 'navigator_panel.dart';

class BaseLayoutPage extends StatefulWidget {
  final Widget child;
  final Widget? title;
  final bool centerTitle;
  final List<Widget>? actions;

  const BaseLayoutPage({
    super.key,
    required this.child,
    this.title,
    this.centerTitle = true,
    this.actions,
  });

  @override
  State<BaseLayoutPage> createState() => _BaseLayoutPageState();
}

class _BaseLayoutPageState extends State<BaseLayoutPage> {
  bool _isPanelOpen = true;

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxPanelWidth = 300.0;
        final double minPanelWidth = 80.0;
        final bool isMobile = constraints.maxWidth < 600;

        final panelWidth = constraints.maxWidth * 0.25;

        if (isMobile) {
          return Scaffold(
            backgroundColor:
                AppTheme.theme(context, null).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor:
              AppTheme.theme(context, null).scaffoldBackgroundColor,
              title: widget.title,
              centerTitle: widget.centerTitle,
              actions: widget.actions,
            ),
            drawer: NavigationPanel(width: maxPanelWidth),
            body: widget.child,
          );
        } else {
          return Scaffold(
            backgroundColor:
                AppTheme.theme(context, null).scaffoldBackgroundColor,
            body: Row(
              children: [
                NavigationPanel(
                  width: _isPanelOpen ? panelWidth : minPanelWidth,
                ),
                Expanded(child: widget.child),
              ],
            ),
          );
        }
      },
    );
  }
}
