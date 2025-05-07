import 'package:flutter/material.dart';

import '../../../features/home/presentation/bloc/chat_bloc/bloc.dart';

class NavigationPanel extends StatelessWidget {
  final double width;

  const NavigationPanel({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.grey[100],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Opciones',
            ), //style: Theme.of(context).textTheme.headline6),
          ),

          // Lista de opciones fijas
          Expanded(
            child: ListView(
              children: [
                _buildOptionItem(context, 'Opción 1', Icons.chat, 'home_chat'),
                _buildOptionItem(context, 'Opción 2', Icons.info, 'projects_chat'),
                _buildOptionItem(context, 'Opción 3', Icons.settings, 'experience_chat'),
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

  Widget _buildOptionItem(BuildContext context, String title, IconData icon, String routeName) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => context.read<ChatBloc>().add(GetChatMessages(routeName)),
    );
  }
}
