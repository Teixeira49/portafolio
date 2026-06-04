part of '../page/home_page.dart';

class _TitleChatHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseStyle = Responsive.isMobile(context)
        ? ExtendedTextTheme.displayExtraSmall(context)
        : ExtendedTextTheme.displaySmall(context);

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: baseStyle,
        children: [
          // Static prefix — inherits base color from theme
          TextSpan(text: context.l10n.appMainTitlePrefix),
          // Accent name — gradient via ShaderMask WidgetSpan
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) =>
                  GradientValues.brandAccent.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                context.l10n.appMainTitleAccent,
                style: baseStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
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

