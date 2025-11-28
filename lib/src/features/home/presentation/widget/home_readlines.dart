part of '../page/home_page.dart';

class _TitleChatHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
    context.l10n.appMainTitle,
    style:
        Responsive.isMobile(context)
            ? ExtendedTextTheme.displayExtraSmall(context)
            : ExtendedTextTheme.displaySmall(context),
    textAlign: TextAlign.center,
  );
}

class _SubTitleChatHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 700),
    child: Text(
      context.l10n.appMainSubtitle,
      style: Responsive.isMobile(context)
          ? ExtendedTextTheme.textSmall(context)
          : ExtendedTextTheme.textLarge(context),
      textAlign: TextAlign.center,
    ),
  );
}

class _ChatTextFieldSearchQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
    key: ValueKey('text'),
    alignment: Alignment.topLeft,
    child: Row(
      spacing: WidthValues.spacingXs,
      children: [
        Icon(Icons.search_outlined, size: 18),
        Text(context.l10n.homePageQuestionLayer),
      ],
    ),
  );
}
