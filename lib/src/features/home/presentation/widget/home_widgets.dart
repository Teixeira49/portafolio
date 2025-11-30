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
          Gap(WidthValues.spacingNone),
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
        child: _ChatTextFieldAnimatedContainer(isSelected: _isSelected),
      ),
    ),
  );
}

class _ChatTextFieldAnimatedContainer extends StatelessWidget {
  const _ChatTextFieldAnimatedContainer({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    alignment: Alignment.topCenter,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(WidthValues.padding),
      decoration: BoxDecoration(
        color: ColorValues.bgSecondary(context),
        borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        border: Border.all(color: ColorValues.borderSolid(context), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: ColorValues.shadowPrimary(context).withAlpha(200),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder:
            (currentChild, previousChildren) => Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            ),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child:
            isSelected
                ? const _QuestionMenu(key: ValueKey('buttons'))
                : _ChatTextFieldDefaultModel(),
      ),
    ),
  );
}

class _ChatTextFieldDefaultModel extends StatelessWidget {
  const _ChatTextFieldDefaultModel();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 120,
    key: const ValueKey('stack'),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 305;
        final children = [
          _ChatTextFieldContainerBotModel(),
          _ChatTextFieldResumeButton(),
        ];
        return Stack(
          children: [
            _ChatTextFieldSearchQuestion(),
            Align(
              alignment:
                  isSmallScreen
                      ? Alignment.bottomRight
                      : Alignment.bottomCenter,
              child:
                  isSmallScreen
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: WidthValues.spacingXs,
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      )
                      : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: children,
                      ),
            ),
          ],
        );
      },
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
      color: ColorValues.utilityGray200(context),
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
      border: Border.all(
        color: ColorValues.borderSolid(context).withAlpha(120),
        width: 0.5,
      ),
    ),
    child: Row(
      spacing: WidthValues.spacingXs,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.homePageIAModelLayer,
          style: ExtendedTextTheme.textSmall(context),
        ),
        Icon(
          Icons.keyboard_arrow_up_outlined,
          color: ColorValues.borderSolid(context).withAlpha(220),
        ),
      ],
    ),
  );
}
