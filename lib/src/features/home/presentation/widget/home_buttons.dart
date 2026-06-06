part of '../page/home_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Question menu — shown when the composer is tapped
// Styled as model-pill chips from the design system
// ─────────────────────────────────────────────────────────────────────────────

class _QuestionMenu extends StatelessWidget {
  const _QuestionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: [
        _QuestionChip(
          question: context.l10n.homePageAboutMeQuestionButton,
          chatRoute: 'about_chat',
        ),
        _QuestionChip(
          question: context.l10n.homePageSkillsQuestionButton,
          chatRoute: 'skills_chat',
        ),
        _QuestionChip(
          question: context.l10n.homePageProjectsQuestionButton,
          chatRoute: 'projects_chat',
        ),
        _QuestionChip(
          question: context.l10n.homePageExperienceQuestionButton,
          chatRoute: 'experience_chat',
        ),
        _QuestionChip(
          question: context.l10n.homePageEducationQuestionButton,
          chatRoute: 'education_chat',
        ),
      ],
    );
  }
}

class _QuestionChip extends StatefulWidget {
  const _QuestionChip({required this.question, required this.chatRoute});
  final String question;
  final String chatRoute;

  @override
  State<_QuestionChip> createState() => _QuestionChipState();
}

class _QuestionChipState extends State<_QuestionChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.chatRoute != curr.chatRoute,
      builder: (context, state) {
        final isActive = state.chatRoute == widget.chatRoute;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final Color bg;
        final Color border;
        final Color text;

        if (isActive) {
          bg = isDark ? const Color(0xFF1A3252) : const Color(0xFFEBF2FF);
          border = isDark ? const Color(0xFF2A5499) : const Color(0xFFBAD0FB);
          text = isDark ? const Color(0xFF6EA8FE) : const Color(0xFF1B5BCC);
        } else if (_hovered) {
          bg = ColorValues.bgChipHover(context);
          border = ColorValues.borderChip(context);
          text = ColorValues.textPrimary(context);
        } else {
          bg = ColorValues.bgChip(context);
          border = ColorValues.borderChip(context);
          text = ColorValues.textSecondary(context);
        }

        return MouseRegion(
          cursor: isActive
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: isActive
                ? null
                : () => context
                    .read<ChatBloc>()
                    .add(GetChatMessages(widget.chatRoute)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: bg,
                border: Border.all(color: border),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.question,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: text,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Social icon row — GitHub · LinkedIn · Gmail
// Styled as .social buttons from the design (44×44, rounded 13px, hover lift)
// ─────────────────────────────────────────────────────────────────────────────

class _ButtonsMenu extends StatelessWidget {
  const _ButtonsMenu();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(
          asset: AssetIcons.iconGithubLight,
          route: 'https://github.com/teixeira49',
          applyColorMask: true,
        ),
        const Gap(10),
        _SocialButton(
          asset: AssetIcons.iconLinkedin,
          route: 'https://www.linkedin.com/in/ing-javier-teixeira/',
        ),
        const Gap(10),
        _SocialButton(
          asset: AssetIcons.iconGmail,
          route: Helpers.sendMeEmail(),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.asset,
    required this.route,
    this.applyColorMask = false,
  });
  final String asset;
  final String route;
  final bool applyColorMask;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = _hovered
        ? ColorValues.textPrimary(context)
        : ColorValues.textTertiary(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.route)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: 44,
          height: 44,
          transform: Matrix4.translationValues(0, _hovered ? -2.0 : 0.0, 0),
          decoration: BoxDecoration(
            color: _hovered
                ? ColorValues.bgSidebarHover(context)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: _hovered
                  ? ColorValues.borderLine(context)
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              widget.asset,
              width: 21,
              height: 21,
              colorFilter: widget.applyColorMask
                  ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
