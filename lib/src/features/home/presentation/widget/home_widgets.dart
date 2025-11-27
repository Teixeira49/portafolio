part of '../page/home_page.dart';

class _WelcomeToChatWidget extends StatelessWidget {
  const _WelcomeToChatWidget();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: WidthValues.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: WidthValues.padding,
        children: [
          _TitleChatHomeWidget(),
          _SubTitleChatHomeWidget(),
          _ChatTextFieldWidget(),
          Gap(WidthValues.spacingNone),
          _ButtonsMenu(),
        ],
      ),
    ),
  );
}

class _ChatTextFieldWidget extends StatefulWidget {
  const _ChatTextFieldWidget();

  @override
  State<_ChatTextFieldWidget> createState() => _ChatTextFieldWidgetState();
}

class _ChatTextFieldWidgetState extends State<_ChatTextFieldWidget> {
  bool _isSelected = false;

  void toggleContainer() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 816),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: WidthValues.padding),
      child: InkWell(
        onTap: () => toggleContainer(),
        borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(WidthValues.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(WidthValues.radiusMd),
            border: Border.all(color: Colors.black54, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder:
                (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
            child:
                _isSelected
                    ? const _QuestionMenu(key: ValueKey('buttons'))
                    : Stack(
                      children: [
                        _ChatTextFieldSearchQuestion(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: _ChatTextFieldContainerBotModel(),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: _ChatTextFieldResumeButton()
                        ),
                      ],
                    ),
          ),
        ),
      ),
    ),
  );
}

class _ChatTextFieldContainerBotModel extends StatelessWidget {
  const _ChatTextFieldContainerBotModel();

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      vertical: WidthValues.spacingXs,
      horizontal: WidthValues.spacingSm,
    ),
    decoration: BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
      border: Border.all(color: Colors.black54, width: 0.5),
    ),
    child: Row(
      spacing: WidthValues.spacingXs,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.l10n.homePageIAModelLayer),
        Icon(Icons.keyboard_arrow_up_outlined, color: Colors.black87),
      ],
    ),
  );
}
