import 'package:flutter/material.dart';

class NavigationPanel extends StatelessWidget {
  final double width;

  const NavigationPanel({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.grey[100],
      child: Column(
        children: [
          // Encabezado
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Opciones', ),//style: Theme.of(context).textTheme.headline6),
          ),

          // Lista de opciones fijas
          Expanded(
            child: ListView(
              children: [
                _buildOptionItem(context, 'Opción 1', Icons.chat),
                _buildOptionItem(context, 'Opción 2', Icons.info),
                _buildOptionItem(context, 'Opción 3', Icons.settings),
                // Agregar más opciones según necesidad
              ],
            ),
          ),

          // Pie de página (opcional)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Versión 1.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Aquí manejas la selección de la opción
        // Puedes usar un Provider, Bloc o simplemente setState
      },
    );
  }
}