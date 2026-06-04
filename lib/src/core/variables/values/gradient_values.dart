import 'package:flutter/material.dart';

/// Brand gradient and surface gradients for the Teixeira Portfolio design system.
///
/// The tri-color gradient mirrors the brand mark: green → blue → red.
/// CSS reference: linear-gradient(105deg, #00E660 0%, #1F55C4 52%, #E60000 100%)
class GradientValues {
  // ------------------------------------------------------------------
  // <--------------- Brand gradients --------------------------------->
  // ------------------------------------------------------------------

  /// Tri-color brand gradient (green → blue → red) at 105°.
  /// Used for accent text, logo mark rings, and decorative elements.
  static const LinearGradient brand = LinearGradient(
    begin: Alignment(-0.966, -0.259),
    end: Alignment(0.966, 0.259),
    colors: [
      Color(0xFF00E660),
      Color(0xFF1F55C4),
      Color(0xFFE60000),
    ],
    stops: [0.0, 0.52, 1.0],
  );

  /// Green → blue half of the brand gradient. Used for the greeting accent text.
  static const LinearGradient brandAccent = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF00E660),
      Color(0xFF1F55C4),
    ],
  );

  // ------------------------------------------------------------------
  // <--------------- Ambient cloud gradients ------------------------->
  // ------------------------------------------------------------------
  // These replicate the blurred ambient glow behind the composer in
  // the design mockup (design/Teixeira Portfolio.html .cloud element).
  // Apply with a blur + low opacity for the correct effect.

  /// Dark-mode ambient cloud: green blob · blue blob · red blob.
  static const RadialGradient cloudGreenDark = RadialGradient(
    center: Alignment(-0.48, -0.16),
    radius: 0.7,
    colors: [Color(0x4D00E660), Colors.transparent],
  );

  static const RadialGradient cloudRedDark = RadialGradient(
    center: Alignment(0.52, 0.20),
    radius: 0.72,
    colors: [Color(0x4DE60000), Colors.transparent],
  );

  static const RadialGradient cloudBlueDark = RadialGradient(
    center: Alignment(0.04, 0.04),
    radius: 0.84,
    colors: [Color(0x4D1F55C4), Colors.transparent],
  );
}
