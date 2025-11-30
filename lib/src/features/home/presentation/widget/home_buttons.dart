part of '../page/home_page.dart';

class _ButtonsMenu extends StatelessWidget {
  const _ButtonsMenu();

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    spacing: WidthValues.spacingXl,
    children: [
      DynamicIconButton(
        asset: AssetIcons.iconGithubLight,
        route: Constants.githubAccount,
        maskColor:
            AppTheme.theme(context, null).brightness == Brightness.dark
                ? ColorValues.fgPrimary(context).withAlpha(180)
                : null,
      ),
      DynamicIconButton(
        asset: AssetIcons.iconLinkedin,
        route: Constants.linkedinAccount,
      ),
      DynamicIconButton(
        asset: AssetIcons.iconGmail,
        route: Helpers.sendMeEmail(),
      ),
    ],
  );
}

class _QuestionMenu extends StatelessWidget {
  const _QuestionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Espacio horizontal entre botones
      runSpacing: 8.0, // Espacio vertical entre filas de botones
      alignment: WrapAlignment.center,
      children: [
        _QuestionButton(
          question: context.l10n.homePageAboutMeQuestionButton,
          chatRoute: 'about_chat',
        ),
        _QuestionButton(
          question: context.l10n.homePageSkillsQuestionButton,
          chatRoute: 'skills_chat',
        ),
        _QuestionButton(
          question: context.l10n.homePageProjectsQuestionButton,
          chatRoute: 'projects_chat',
        ),
        _QuestionButton(
          question: context.l10n.homePageExperienceQuestionButton,
          chatRoute: 'experience_chat',
        ),
        _QuestionButton(
          question: context.l10n.homePageEducationQuestionButton,
          chatRoute: 'education_chat',
        ),
      ],
    );
  }
}

class _QuestionButton extends StatelessWidget {
  const _QuestionButton({required this.question, required this.chatRoute});

  final String question;
  final String chatRoute;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: () => context.read<ChatBloc>().add(GetChatMessages(chatRoute)),
    child: Text(
      question,
      style: ExtendedTextTheme.textSmall(context),
      textAlign: TextAlign.center,
    ),
  );
}

class _ChatTextFieldResumeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
    onPressed: () => launchUrl(Uri.parse(Constants.resume)),
    icon: Icon(Icons.download_outlined),
    label: Text(context.l10n.homePageDownloadResumeButton),
  );
}
