import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/src/core/theme/app_theme.dart';
import 'package:portafolio/src/features/home/data/repositories/home_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:portafolio/l10n/l10n.dart';
import '../../../../core/theme/responsive.dart';
import '../../../../core/utils/asset_icons.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/variables/variables.dart';
import '../../../../shared/presentation/widgets/base_layout.dart';
import '../../../../shared/presentation/widgets/custom_badged.dart';
import '../../../../shared/presentation/widgets/dynamic_icon_button.dart';
import '../../../../shared/presentation/widgets/message_content.dart';
import '../../data/datasource/local/get_chat_local_datasource.dart';
import '../../domain/use_cases/get_messages.dart';
import '../bloc/chat_bloc/bloc.dart';

part '../widget/home_body.dart';

part '../widget/home_buttons.dart';

part '../widget/home_readlines.dart';

part '../widget/home_widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create:
              (context) => ChatBloc(
                getMessages: GetMessagesUseCase(
                  HomeRepository(
                    getChatMessagesDatasource: GetChatMessagesDatasourceImpl(),
                  ),
                ),
              )..add(GetChatMessages('home_chat')),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final title =
            state.chatName != "Home Chat"
                ? Text('Portafolio de Teixeira49')
                : null;
        return BaseLayoutPage(
          title: title,
          centerTitle: false,
          actions: [
            if (title != null) CustomTitleBadged(name: state.chatName),
          ],
          child: HomeBody(),
        );
      },
    );
  }
}
