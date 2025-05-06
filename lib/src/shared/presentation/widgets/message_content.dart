
import 'package:flutter/material.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // Ejemplo de mensaje del sistema
          _buildSystemMessage('Bienvenido a nuestra plataforma'),

          // Ejemplo de contenido informativo
          _buildInfoCard(
            title: 'Información importante',
            content: 'Aquí va el contenido que la empresa quiere mostrar...',
          ),

          // Puedes agregar más widgets según lo que necesiten mostrar
        ],
      ),
    );
  }

  Widget _buildSystemMessage(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
