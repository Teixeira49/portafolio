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
        return state.chatName == "Home Chat"
            ? _WelcomeToChatWidget()
            : Scaffold(
              appBar:
                  state.chatName != "Home Chat" && !Responsive.isMobile(context)
                      ? AppBar(
                        title: Text('Portafolio de Teixeira49'),
                        centerTitle: true,
                        actions: [
                          CustomTitleBadged(name: state.chatName),
                        ],
                      )
                      : null,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  MessageContent(
                    title: state.chatName,
                    content: state.messages.isNotEmpty ? state.messages : [],
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
