import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const yellow = Color(0xFFF7D44C);
const red = Color(0xFFEA7A53);


CustomColors lightCustomColors = const CustomColors(
  sourceYellow: Color(0xFFF7D44C),
  yellow: Color(0xFF705D00),
  onYellow: Color(0xFFFFFFFF),
  yellowContainer: Color(0xFFFFE175),
  onYellowContainer: Color(0xFF221B00),
  sourceRed: Color(0xFFEA7A53),
  red: Color(0xFF9F411F),
  onRed: Color(0xFFFFFFFF),
  redContainer: Color(0xFFFFDBD0),
  onRedContainer: Color(0xFF390C00),
);

CustomColors darkCustomColors = const CustomColors(
  sourceYellow: Color(0xFFF7D44C),
  yellow: Color(0xFFE6C43D),
  onYellow: Color(0xFF3B2F00),
  yellowContainer: Color(0xFF554500),
  onYellowContainer: Color(0xFFFFE175),
  sourceRed: Color(0xFFEA7A53),
  red: Color(0xFFFFB59D),
  onRed: Color(0xFF5D1900),
  redContainer: Color(0xFF7F2B09),
  onRedContainer: Color(0xFFFFDBD0),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceYellow,
    required this.yellow,
    required this.onYellow,
    required this.yellowContainer,
    required this.onYellowContainer,
    required this.sourceRed,
    required this.red,
    required this.onRed,
    required this.redContainer,
    required this.onRedContainer,
  });

  final Color? sourceYellow;
  final Color? yellow;
  final Color? onYellow;
  final Color? yellowContainer;
  final Color? onYellowContainer;
  final Color? sourceRed;
  final Color? red;
  final Color? onRed;
  final Color? redContainer;
  final Color? onRedContainer;

  @override
  CustomColors copyWith({
    Color? sourceYellow,
    Color? yellow,
    Color? onYellow,
    Color? yellowContainer,
    Color? onYellowContainer,
    Color? sourceRed,
    Color? red,
    Color? onRed,
    Color? redContainer,
    Color? onRedContainer,
  }) {
    return CustomColors(
      sourceYellow: sourceYellow ?? this.sourceYellow,
      yellow: yellow ?? this.yellow,
      onYellow: onYellow ?? this.onYellow,
      yellowContainer: yellowContainer ?? this.yellowContainer,
      onYellowContainer: onYellowContainer ?? this.onYellowContainer,
      sourceRed: sourceRed ?? this.sourceRed,
      red: red ?? this.red,
      onRed: onRed ?? this.onRed,
      redContainer: redContainer ?? this.redContainer,
      onRedContainer: onRedContainer ?? this.onRedContainer,
    );
  }
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceYellow: Color.lerp(sourceYellow, other.sourceYellow, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      onYellow: Color.lerp(onYellow, other.onYellow, t),
      yellowContainer: Color.lerp(yellowContainer, other.yellowContainer, t),
      onYellowContainer: Color.lerp(onYellowContainer, other.onYellowContainer, t),
      sourceRed: Color.lerp(sourceRed, other.sourceRed, t),
      red: Color.lerp(red, other.red, t),
      onRed: Color.lerp(onRed, other.onRed, t),
      redContainer: Color.lerp(redContainer, other.redContainer, t),
      onRedContainer: Color.lerp(onRedContainer, other.onRedContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
    );
  }
}