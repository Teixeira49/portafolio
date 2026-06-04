import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Eng. Teixeira'**
  String get appTitle;

  /// No description provided for @appMainTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello, I am Engineer Teixeira'**
  String get appMainTitle;

  /// No description provided for @appMainTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Hello, I am '**
  String get appMainTitlePrefix;

  /// No description provided for @appMainTitleAccent.
  ///
  /// In en, this message translates to:
  /// **'Engineer Teixeira'**
  String get appMainTitleAccent;

  /// No description provided for @appMainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to my portfolio, here you can find my skills and projects'**
  String get appMainSubtitle;

  /// No description provided for @dashboardHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboardHomeButton;

  /// No description provided for @dashboardAboutMeButton.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get dashboardAboutMeButton;

  /// No description provided for @dashboardSkillsButton.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get dashboardSkillsButton;

  /// No description provided for @dashboardProjectsButton.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get dashboardProjectsButton;

  /// No description provided for @dashboardExperienceButton.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get dashboardExperienceButton;

  /// No description provided for @dashboardEducationButton.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get dashboardEducationButton;

  /// No description provided for @dashboardContactButton.
  ///
  /// In en, this message translates to:
  /// **'Contact me'**
  String get dashboardContactButton;

  /// No description provided for @dashboardConfigButton.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get dashboardConfigButton;

  /// No description provided for @dashboardClosePanelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Collapse Panel'**
  String get dashboardClosePanelTooltip;

  /// No description provided for @dashboardOpenPanelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Expand Panel'**
  String get dashboardOpenPanelTooltip;

  /// No description provided for @homePageQuestionLayer.
  ///
  /// In en, this message translates to:
  /// **'Ask your question...'**
  String get homePageQuestionLayer;

  /// No description provided for @homePageIAModelLayer.
  ///
  /// In en, this message translates to:
  /// **'Teixeira V.1.0'**
  String get homePageIAModelLayer;

  /// No description provided for @homePageDownloadResumeButton.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get homePageDownloadResumeButton;

  /// No description provided for @homePageAboutMeQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get homePageAboutMeQuestionButton;

  /// No description provided for @homePageSkillsQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'What skills do you have?'**
  String get homePageSkillsQuestionButton;

  /// No description provided for @homePageProjectsQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'Show me your projects'**
  String get homePageProjectsQuestionButton;

  /// No description provided for @homePageExperienceQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'What is your experience?'**
  String get homePageExperienceQuestionButton;

  /// No description provided for @homePageEducationQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'What is your level of education?'**
  String get homePageEducationQuestionButton;

  /// No description provided for @homePageGithubTooltip.
  ///
  /// In en, this message translates to:
  /// **'View profile on GitHub'**
  String get homePageGithubTooltip;

  /// No description provided for @homePageLinkedinTooltip.
  ///
  /// In en, this message translates to:
  /// **'View profile on LinkedIn'**
  String get homePageLinkedinTooltip;

  /// No description provided for @homePageGmailTooltip.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get homePageGmailTooltip;

  /// No description provided for @skillsPageLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get skillsPageLevelLabel;

  /// No description provided for @skillsPageLowLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Novice'**
  String get skillsPageLowLevelLabel;

  /// No description provided for @skillsPageMediumLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get skillsPageMediumLevelLabel;

  /// No description provided for @skillsPageHighLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get skillsPageHighLevelLabel;

  /// No description provided for @projectActualDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Actually'**
  String get projectActualDateLabel;

  /// No description provided for @projectIsPrivateLabel.
  ///
  /// In en, this message translates to:
  /// **'This project is private'**
  String get projectIsPrivateLabel;

  /// No description provided for @settingsPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageLabel;

  /// No description provided for @settingsPageThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsPageThemeLabel;

  /// No description provided for @settingsPageLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsPageLanguageLabel;

  /// No description provided for @settingsPageIAModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get settingsPageIAModelLabel;

  /// No description provided for @contactPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact me'**
  String get contactPageLabel;

  /// No description provided for @contactPageMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I saw your portfolio and I would like to contact you.'**
  String get contactPageMessage;

  /// No description provided for @closeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButtonLabel;

  /// No description provided for @continueButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonLabel;

  /// No description provided for @goBackButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get goBackButtonLabel;

  /// No description provided for @acceptButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptButtonLabel;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @languageNativeLabel.
  ///
  /// In en, this message translates to:
  /// **'Native'**
  String get languageNativeLabel;

  /// No description provided for @languageIntermediateLabel.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get languageIntermediateLabel;

  /// No description provided for @languageButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageButtonLabel;

  /// No description provided for @languageSpanishLabel.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanishLabel;

  /// No description provided for @languageEnglishLabel.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishLabel;

  /// No description provided for @languageSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'Automatic (System)'**
  String get languageSystemLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLightLabel;

  /// No description provided for @themeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDarkLabel;

  /// No description provided for @themeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystemLabel;

  /// No description provided for @chatYouLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get chatYouLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Caracas, Venezuela'**
  String get locationLabel;

  /// No description provided for @visitWebsiteButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Visit Website'**
  String get visitWebsiteButtonLabel;

  /// No description provided for @resumeYearsCompleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience years'**
  String get resumeYearsCompleteLabel;

  /// No description provided for @resumeProjectsCompleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Projects completed'**
  String get resumeProjectsCompleteLabel;

  /// No description provided for @resumeTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'System Engineer | Developer'**
  String get resumeTitleLabel;

  /// No description provided for @dateJanuaryLabel.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get dateJanuaryLabel;

  /// No description provided for @dateFebruaryLabel.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get dateFebruaryLabel;

  /// No description provided for @dateMarchLabel.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get dateMarchLabel;

  /// No description provided for @dateAprilLabel.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get dateAprilLabel;

  /// No description provided for @dateMayLabel.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get dateMayLabel;

  /// No description provided for @dateJuneLabel.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get dateJuneLabel;

  /// No description provided for @dateJulyLabel.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get dateJulyLabel;

  /// No description provided for @dateAugustLabel.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get dateAugustLabel;

  /// No description provided for @dateSeptemberLabel.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get dateSeptemberLabel;

  /// No description provided for @dateOctoberLabel.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get dateOctoberLabel;

  /// No description provided for @dateNovemberLabel.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get dateNovemberLabel;

  /// No description provided for @dateDecemberLabel.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get dateDecemberLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
