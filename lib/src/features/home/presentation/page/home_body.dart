part of 'home_page.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen:
          (previous, current) =>
              previous.status != current.status ||
              previous.chatName != current.chatName ||
              previous.chatId != current.chatId,
      builder: (context, state) {
        return Center(
          child: Row(
            children: [
              // Panel lateral (navegación)
              NavigationPanel(width: 300),

              // Área principal del chat
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Barra superior (opcional)
                    AppBar(title: Text('Título de la aplicación')),

                    // Área de mensajes/contenido
                    Expanded(
                      child: MessageContent(
                        title: state.chatName,
                        content:
                            state.messages.isNotEmpty
                                ? state.messages
                                : [],
                      ),
                    ),

                    // Área de entrada (opcional)
                    //MessageInput(),
                    Text('aqui rspondes'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
