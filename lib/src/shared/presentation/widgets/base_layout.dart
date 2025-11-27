
// main_layout_page.dart

import 'package:flutter/material.dart';

import '../../../core/theme/responsive.dart';
import 'navigator_panel.dart';

class BaseLayoutPage extends StatefulWidget {
  final Widget child; // El contenido principal que se mostrará a la derecha

  const BaseLayoutPage({super.key, required this.child});

  @override
  State<BaseLayoutPage> createState() => _BaseLayoutPageState();
}

class _BaseLayoutPageState extends State<BaseLayoutPage> {
  bool _isPanelOpen = true; // Por defecto, el panel está abierto

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para obtener las dimensiones de la pantalla y hacerlo adaptable
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define los tamaños del panel
        final double maxPanelWidth = 300.0; // Ancho máximo cuando está abierto
        final double minPanelWidth = 80.0;  // Ancho mínimo cuando está colapsado
        final bool isMobile = constraints.maxWidth < 600; // Define un punto de quiebre para móviles

        final panelWidth = constraints.maxWidth * 0.25;

        // Si es móvil, usamos un Drawer tradicional. Si no, usamos el panel persistente.
        if (isMobile) {
          return Scaffold(
            drawer: NavigationPanel(
              width: maxPanelWidth, // El drawer siempre tiene su ancho máximo
            ),
            body: widget.child,
          );
        } else {
          // Layout para pantallas grandes (tablets, web, desktop)
          return Scaffold(
            body: Row(
              children: [
                // Panel de Navegación Animado
                NavigationPanel(
                    width: _isPanelOpen ? panelWidth : minPanelWidth,
                  ),

                // Contenido Principal
                Expanded(
                  child: widget.child, // Aquí va el contenido de la página (ej. tu chat)
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
