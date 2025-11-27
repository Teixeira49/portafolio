import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/src/features/home/data/repositories/home_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:portafolio/l10n/l10n.dart';
import '../../../../core/theme/extended_text_theme.dart';
import '../../../../core/utils/asset_icons.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/variables/values/values.dart';
import '../../../../core/variables/variables.dart';
import '../../../../shared/presentation/widgets/base_layout.dart';
import '../../../../shared/presentation/widgets/dynamic_icon_button.dart';
import '../../../../shared/presentation/widgets/message_content.dart';
import '../../data/datasource/local/get_chat_local_datasource.dart';
import '../../domain/use_cases/get_messages.dart';
import '../bloc/chat_bloc/bloc.dart';

part '../widget/home_body.dart';

part '../widget/home_buttons.dart';

part '../widget/home_readlines.dart';

part '../widget/home_widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
      child: HomeView()
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayoutPage(
      child: HomeBody()
    );
  }
}