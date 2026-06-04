// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portafolio/src/core/variables/values/color_values.dart';
import 'package:portafolio/src/core/variables/values/text_values.dart';

extension ExtendedTextTheme on TextTheme {
  static TextStyle displayTwoExtraLarge(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: TextValues.display2xl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraLarge(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: TextValues.displayXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayLarge(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.displayLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.displayMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displaySmall(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.displaySm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraSmall(BuildContext context) =>
      GoogleFonts.plusJakartaSans(
        fontSize: TextValues.displayXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraLarge(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.textXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textLarge(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.textLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textMedium(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.textMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textSmall(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.textSm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraSmall(BuildContext context) => GoogleFonts.plusJakartaSans(
        fontSize: TextValues.textXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle titleExtraLarge(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: TextValues.textXl,
    fontWeight: TextValues.semibold,
    color: ColorValues.textPrimary(context),
  );

  static TextStyle titleLarge(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: TextValues.textLg,
    fontWeight: TextValues.semibold,
    color: ColorValues.textPrimary(context),
  );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: TextValues.textMd,
    fontWeight: TextValues.semibold,
    color: ColorValues.textPrimary(context),
  );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: TextValues.textSm,
    fontWeight: TextValues.semibold,
    color: ColorValues.textPrimary(context),
  );

  static TextStyle titleExtraSmall(BuildContext context) => GoogleFonts.plusJakartaSans(
    fontSize: TextValues.textXs,
    fontWeight: TextValues.semibold,
    color: ColorValues.textPrimary(context),
  );
}
