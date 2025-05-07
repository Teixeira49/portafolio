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
          SizedBox(height: 24,),
          MaterialButton(
            color: Colors.blue,
              child: Text('Contactar'),
              onPressed: () {

              }),
          SizedBox(height: 24,),
          Expanded(
            child: ListView(
              children: [
                _buildOptionItem(context, 'Home', Icons.chat, 'home_chat'),
                _buildOptionItem(context, 'Projects', Icons.info, 'projects_chat'),
                _buildOptionItem(context, 'Experience', Icons.settings, 'experience_chat'),
                //_buildOptionItem(context, 'Study', Icons.settings, 'experience_chat'),
                //_buildOptionItem(context, 'Stats', Icons.settings, 'experience_chat'),
                //_buildOptionItem(context, 'About', Icons.settings, 'experience_chat'),
                // Agregar más opciones según necesidad
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings,),
            title: Text('Configuración'),
            onTap: () {

            },
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
