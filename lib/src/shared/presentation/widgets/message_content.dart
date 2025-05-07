import 'package:flutter/material.dart';

import '../../../features/home/domain/entities/message.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({super.key, required this.title, required this.content});

  final String title;
  final List<Message> content;

  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSystemMessage(title),
          Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                interactive: true,
                controller: scrollController,
                child: ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(right: 16.0),
                  itemCount: content.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _buildInfoCard(
                      title: content[index].member,
                      content: content[index].text,
                    );
                  },
                ),
             )
          )

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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (title == 'You') SizedBox(width: 45),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    title == 'You'
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: title == 'You' ? TextAlign.end : TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(content, textAlign: TextAlign.justify, style: TextStyle(),),
                ],
              ),
            ),
          ),
        ),
        if (title != 'You') SizedBox(width: 45),
        // Espacio entre la tarjeta y el borde
      ],
    );
  }
}
