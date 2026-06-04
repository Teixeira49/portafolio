part of 'package:portafolio/src/core/variables/values/color_values.dart';

/// Color palette for the Teixeira Portfolio design system.
/// Tri-color brand: green (#00E660) · blue (#1F55C4) · red (#E60000)
class _ColorConstants {
  /// Brand green — CTA buttons, gradient start. Design: --c-green #00E660
  static const MaterialColor brandSecond = MaterialColor(
    _brandColorPrimaryValue,
    <int, Color>{
      50: Color(0xFFE6FFED),
      100: Color(0xFFCFFFDC),
      200: Color(0xFF99FFBA),
      300: Color(0xFF66FF97),
      400: Color(0xFF33FF74),
      500: Color(_brandColorPrimaryValue),
      600: Color(0xFF00B84D),
      700: Color(0xFF008A3A),
      800: Color(0xFF005C27),
      900: Color(0xFF002E13),
    },
  );

  static const int _brandColorPrimaryValue = 0xFF00E660;

  /// Brand blue — primary interactive color. Design: --c-blue #1F55C4
  static const MaterialColor brandFirstColor =
  MaterialColor(_brandColorSecondaryValue, <int, Color>{
    50: Color(0xFFEEF2FD),
    100: Color(0xFFD4E0F9),
    200: Color(0xFFAABEF3),
    300: Color(0xFF7F9EED),
    400: Color(0xFF547DE7),
    500: Color(_brandColorSecondaryValue),
    600: Color(0xFF1844A0),
    700: Color(0xFF12347C),
    800: Color(0xFF0C2458),
    900: Color(0xFF071434),
  });

  static const int _brandColorSecondaryValue = 0xFF1F55C4;

  /// Light-mode surface palette — greenish tones from the design mockup.
  /// 50=#FFFFFF (sidebar) · 100=#EEF3F1 (bg) · 800=#17231E (txt)
  static const MaterialColor grayLight =
      MaterialColor(_grayLightPrimaryValue, <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFEEF3F1),
    200: Color(0xFFE8F1ED),
    300: Color(0xFFE0E8E4),
    400: Color(0xFFDCEBE5),
    500: Color(_grayLightPrimaryValue),
    600: Color(0xFF51605A),
    700: Color(0xFF344054),
    800: Color(0xFF17231E),
    900: Color(0xFF0F1A15),
  });

  static const int _grayLightPrimaryValue = 0xFF8A9893;

  /// Dark-mode surface palette — near-black charcoal tones from the design mockup.
  /// 50=#ECEDEE (txt) · 800=#161718 (sidebar) · 900=#0D0E0F (bg)
  static const MaterialColor grayDark =
      MaterialColor(_grayDarkPrimaryValue, <int, Color>{
    50: Color(0xFFECEDEE),
    100: Color(0xFFCECFD2),
    200: Color(0xFFA3A7AA),
    300: Color(0xFF74787B),
    400: Color(0xFF61646C),
    500: Color(_grayDarkPrimaryValue),
    600: Color(0xFF262829),
    700: Color(0xFF202223),
    800: Color(0xFF161718),
    900: Color(0xFF0D0E0F),
  });

  static const int _grayDarkPrimaryValue = 0xFF2A2C2D;

  static const MaterialColor success =
      MaterialColor(_successPrimaryValue, <int, Color>{
    50: Color(0xFFE6F6F5),
    100: Color(0xFFB1E3DE),
    200: Color(0xFF8BD6CF),
    300: Color(0xFF56C3B9),
    400: Color(0xFF35B8AB),
    500: Color(_successPrimaryValue),
    600: Color(0xFF039789),
    700: Color(0xFF02766B),
    800: Color(0xFF025B53),
    900: Color(0xFF01463F),
  });
  static const int _successPrimaryValue = 0xFF03A696;

  static const MaterialColor warning =
      MaterialColor(_warningPrimaryValue, <int, Color>{
    50: Color(0xFFFFFAEB),
    100: Color(0xFFFEF0C7),
    200: Color(0xFFFEDF89),
    300: Color(0xFFFEC84B),
    400: Color(0xFFFDB022),
    500: Color(_warningPrimaryValue),
    600: Color(0xFFDC6803),
    700: Color(0xFFB54708),
    800: Color(0xFF93370D),
    900: Color(0xFF7A2E0E),
  });
  static const int _warningPrimaryValue = 0xFFF79009;

  static const MaterialColor error =
      MaterialColor(_errorPrimaryValue, <int, Color>{
    50: Color(0xFFFEF3F2),
    100: Color(0xFFFEE4E2),
    200: Color(0xFFFECDCA),
    300: Color(0xFFFDA29B),
    400: Color(0xFFF97066),
    500: Color(_errorPrimaryValue),
    600: Color(0xFFD92D20),
    700: Color(0xFFB42318),
    800: Color(0xFF912018),
    900: Color(0xFF7A271A),
  });
  static const int _errorPrimaryValue = 0xFFF04438;

  static const MaterialColor greenConstant = MaterialColor(
    _greenConstantPrimaryValue, <int, Color>{
      50: Color(0xFFE6F6F5),
      100: Color(0xFFD3ECE3),
      200: Color(0xFF8BD6AC),
      300: Color(0xFF56C37C),
      400: Color(0xFF35B84F),
      500: Color(_greenConstantPrimaryValue),
      600: Color(0xFF03974D),
      700: Color(0xFF02762B),
      800: Color(0xFF025B21),
      900: Color(0xFF014619),
  });

  static const int _greenConstantPrimaryValue = 0xFF1AB864;

  static const MaterialColor yellowConstant = MaterialColor(
    _yellowConstantPrimaryValue, <int, Color>{
      50: Color(0xFFFEF9E6),
      100: Color(0xFFFEF3C7),
      200: Color(0xFFFEDF89),
      300: Color(0xFFFEC84B),
      400: Color(0xFFFDB022),
      500: Color(_yellowConstantPrimaryValue),
      600: Color(0xFFDC6803),
      700: Color(0xFFB54708),
      800: Color(0xFF93370D),
  });

  static const int _yellowConstantPrimaryValue = 0xFFF79009;

  /// Brand red — logo mark, gradient end. Design: --c-red #E60000
  static const MaterialColor redConstant = MaterialColor(
  _redConstantPrimaryValue, <int, Color>{
    50: Color(0xFFFFECEC),
    100: Color(0xFFFFD9D9),
    200: Color(0xFFFFB3B3),
    300: Color(0xFFFF8080),
    400: Color(0xFFFF4D4D),
    500: Color(_redConstantPrimaryValue),
    600: Color(0xFFCC0000),
    700: Color(0xFF990000),
    800: Color(0xFF660000),
    900: Color(0xFF330000),
  });

  static const int _redConstantPrimaryValue = 0xFFE60000;

  static const MaterialColor blueConstant = MaterialColor(
  _blueConstantPrimaryValue, <int, Color>{
    50: Color(0xFFE6EDF6),
    100: Color(0xFFD3E0EC),
    200: Color(0xFF8BB4D6),
    300: Color(0xFF569DC3),
    400: Color(0xFF358AB8),
    500: Color(_blueConstantPrimaryValue),
    600: Color(0xFF035997),
    700: Color(0xFF024A76),
    800: Color(0xFF023C5B),
    900: Color(0xFF013146),
  });

  static const int _blueConstantPrimaryValue = 0xFF1A71B8;

  static const MaterialColor greenSecondaryConstant = MaterialColor(
      _greenConstantPrimaryValue, <int, Color>{
    50: Color(0xFFCFFFF2),
    100: Color(0xFFA5F4D9),
    200: Color(0xFF6AF1C3),
    300: Color(0xFF3EEFB2),
    400: Color(0xFF1DD394),
    500: Color(_greenSecondaryConstantPrimaryValue),
    600: Color(0xFF00AC71),
    700: Color(0xFF018E5E),
    800: Color(0xFF006141),
    900: Color(0xFF00422C),
  });

  static const int _greenSecondaryConstantPrimaryValue = 0xFF08BD7F;

  static const MaterialColor blueSecondaryConstant = MaterialColor(
      _blueSecondaryConstantPrimaryValue, <int, Color>{
    50: Color(0xff98adff),
    100: Color(0xff7a96ff),
    200: Color(0xff5576f3),
    300: Color(0xff3f64ef),
    400: Color(0xff284fe1),
    500: Color(_blueSecondaryConstantPrimaryValue),
    600: Color(0xff1539bc),
    700: Color(0xff0f2fa1),
    800: Color(0xff092588),
    900: Color(0xff041b70),
  });

  static const int _blueSecondaryConstantPrimaryValue = 0xff193fcc;
}
