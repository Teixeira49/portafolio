// main_layout_page.dart

import 'package:flutter/material.dart';

import 'navigator_panel.dart';

class BaseLayoutPage extends StatefulWidget {
  final Widget child;
  final Widget? title;

  const BaseLayoutPage({super.key, required this.child, this.title});

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
            appBar: AppBar(title: widget.title),
            drawer: NavigationPanel(width: maxPanelWidth),
            body: widget.child,
          );
        } else {
          return Scaffold(
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
