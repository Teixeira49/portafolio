// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Portfolio Eng. Teixeira';

  @override
  String get appMainTitle => 'Hello, I am Engineer Teixeira';

  @override
  String get appMainTitlePrefix => 'Hello, I am ';

  @override
  String get appMainTitleAccent => 'Engineer Teixeira';

  @override
  String get appMainSubtitle =>
      'Welcome to my portfolio, here you can find my skills and projects';

  @override
  String get dashboardHomeButton => 'Home';

  @override
  String get dashboardAboutMeButton => 'About me';

  @override
  String get dashboardSkillsButton => 'Skills';

  @override
  String get dashboardProjectsButton => 'Projects';

  @override
  String get dashboardExperienceButton => 'Experience';

  @override
  String get dashboardEducationButton => 'Education';

  @override
  String get dashboardContactButton => 'Contact me';

  @override
  String get dashboardConfigButton => 'Settings';

  @override
  String get dashboardClosePanelTooltip => 'Collapse Panel';

  @override
  String get dashboardOpenPanelTooltip => 'Expand Panel';

  @override
  String get homePageQuestionLayer => 'Ask your question...';

  @override
  String get homePageIAModelLayer => 'Teixeira V.1.0';

  @override
  String get modelFlashSubtitle => 'Fast and concise';

  @override
  String get modelProSubtitle => 'Detailed and thorough';

  @override
  String get homePageDownloadResumeButton => 'Resume';

  @override
  String get homePageAboutMeQuestionButton => 'Who are you?';

  @override
  String get homePageSkillsQuestionButton => 'What skills do you have?';

  @override
  String get homePageProjectsQuestionButton => 'Show me your projects';

  @override
  String get homePageExperienceQuestionButton => 'What is your experience?';

  @override
  String get homePageEducationQuestionButton =>
      'What is your level of education?';

  @override
  String get homePageGithubTooltip => 'View profile on GitHub';

  @override
  String get homePageLinkedinTooltip => 'View profile on LinkedIn';

  @override
  String get homePageGmailTooltip => 'Send email';

  @override
  String get skillsPageLevelLabel => 'Level';

  @override
  String get skillsPageLowLevelLabel => 'Novice';

  @override
  String get skillsPageMediumLevelLabel => 'Intermediate';

  @override
  String get skillsPageHighLevelLabel => 'Expert';

  @override
  String get projectActualDateLabel => 'Actually';

  @override
  String get projectIsPrivateLabel => 'This project is private';

  @override
  String get settingsPageLabel => 'Settings';

  @override
  String get settingsPageThemeLabel => 'Theme';

  @override
  String get settingsPageLanguageLabel => 'Language';

  @override
  String get settingsPageIAModelLabel => 'Model';

  @override
  String get contactPageLabel => 'Contact me';

  @override
  String get contactPageMessage =>
      'Hello, I saw your portfolio and I would like to contact you.';

  @override
  String get closeButtonLabel => 'Close';

  @override
  String get continueButtonLabel => 'Continue';

  @override
  String get goBackButtonLabel => 'Back';

  @override
  String get acceptButtonLabel => 'Accept';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get languageNativeLabel => 'Native';

  @override
  String get languageIntermediateLabel => 'Intermediate';

  @override
  String get languageButtonLabel => 'Language';

  @override
  String get languageSpanishLabel => 'Spanish';

  @override
  String get languageEnglishLabel => 'English';

  @override
  String get languageSystemLabel => 'Automatic (System)';

  @override
  String get themeLightLabel => 'Light';

  @override
  String get themeDarkLabel => 'Dark';

  @override
  String get themeSystemLabel => 'System';

  @override
  String get chatYouLabel => 'You';

  @override
  String get locationLabel => 'Caracas, Venezuela';

  @override
  String get visitWebsiteButtonLabel => 'Visit Website';

  @override
  String get resumeYearsCompleteLabel => 'Experience years';

  @override
  String get resumeProjectsCompleteLabel => 'Projects completed';

  @override
  String get resumeTitleLabel => 'System Engineer | Developer';

  @override
  String get dateJanuaryLabel => 'January';

  @override
  String get dateFebruaryLabel => 'February';

  @override
  String get dateMarchLabel => 'March';

  @override
  String get dateAprilLabel => 'April';

  @override
  String get dateMayLabel => 'May';

  @override
  String get dateJuneLabel => 'June';

  @override
  String get dateJulyLabel => 'July';

  @override
  String get dateAugustLabel => 'August';

  @override
  String get dateSeptemberLabel => 'September';

  @override
  String get dateOctoberLabel => 'October';

  @override
  String get dateNovemberLabel => 'November';

  @override
  String get dateDecemberLabel => 'December';

  @override
  String get educationDegreeTitle => 'Systems Engineer';

  @override
  String get educationUniversityName =>
      'Metropolitan University of Venezuela (UNIMET)';

  @override
  String get educationGraduatedLabel => 'Graduated · Oct 2025';

  @override
  String get educationViewCertificateLabel => 'View Certificate';

  @override
  String get skillsFavoriteTooltip => 'Favorite technology';

  @override
  String get projectFavoriteTooltip => 'Favorite project';

  @override
  String projectEducationalTooltip(String institution) {
    return 'Educational project made for $institution';
  }
}
