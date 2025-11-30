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
            : Stack(
              alignment: Alignment.topCenter,
              children: [
                if (state.chatName != "Home Chat" &&
                    !Responsive.isMobile(context)) ...[
                  Positioned(
                    top: WidthValues.padding,
                    child: Text(
                      context.l10n.appTitle,
                      style: ExtendedTextTheme.titleMedium(context),
                    ),
                  ),
                  Positioned(
                    top: WidthValues.padding,
                    right: WidthValues.padding,
                    child: CustomTitleBadged(name: state.chatName),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.only(top: WidthValues.spacing2xl),
                  child: MessageContent(
                    title: state.chatName,
                    content: state.messages.isNotEmpty ? state.messages : [],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: WidthValues.padding),
                    child: _ChatTextFieldWidget(),
                  ),
                ),
              ],
            );
      },
    );
  }
}
