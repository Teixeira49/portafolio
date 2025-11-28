part of '../page/home_page.dart';

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
        return Scaffold(
          appBar:
              state.chatName != "Home Chat"
                  ? AppBar(title: Text('Portafolio de Teixeira49'))
                  : null,
          body:
              state.chatName == "Home Chat"
                  ? _WelcomeToChatWidget()
                  : Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      MessageContent(
                        title: state.chatName,
                        content:
                            state.messages.isNotEmpty ? state.messages : [],
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: WidthValues.padding),
                          child: _ChatTextFieldWidget(),
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }
}
