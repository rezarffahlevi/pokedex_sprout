
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/themes/my_font_weight.dart';

/// [MyTextStyle] like css
/// easier when giving TextStyle and high custom
class MyTextStyle {
  static const String fontFamily = 'CircularStd';

  // Base Text Style
  static TextStyle baseText({
    double? fontSize = 14,
    FontWeight fontWeight = MyFontWeight.regular,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static MyTextStyleFontWeight get h1 =>
      MyTextStyleFontWeight.custom(fontSize: 28.sp);
  static MyTextStyleFontWeight get h2 =>
      MyTextStyleFontWeight.custom(fontSize: 24.sp);
  static MyTextStyleFontWeight get h3 =>
      MyTextStyleFontWeight.custom(fontSize: 20.sp);
  static MyTextStyleFontWeight get h4 =>
      MyTextStyleFontWeight.custom(fontSize: 18.sp);
  static MyTextStyleFontWeight get h5 =>
      MyTextStyleFontWeight.custom(fontSize: 16.sp);
  static MyTextStyleFontWeight get h6 =>
      MyTextStyleFontWeight.custom(fontSize: 14.sp);
  static MyTextStyleFontWeight get h7 =>
      MyTextStyleFontWeight.custom(fontSize: 12.sp);
  static MyTextStyleFontWeight get h8 =>
      MyTextStyleFontWeight.custom(fontSize: 10.sp);
  static MyTextStyleFontWeight get h9 =>
      MyTextStyleFontWeight.custom(fontSize: 8.sp);
}

// ignore: must_be_immutable
class MyTextStyleFontWeight extends TextStyle {
  double? fontSize;

  MyTextStyleFontWeight();

  MyTextStyleFontWeight.custom({this.fontSize});

  TextStyle get thin => MyTextStyle.baseText(
        fontWeight: MyFontWeight.thin,
        fontSize: this.fontSize,
      );

  TextStyle get extraLight => MyTextStyle.baseText(
        fontWeight: MyFontWeight.extraLight,
        fontSize: this.fontSize,
      );

  TextStyle get light => MyTextStyle.baseText(
        fontWeight: MyFontWeight.light,
        fontSize: this.fontSize,
      );

  TextStyle get regular => MyTextStyle.baseText(
        fontWeight: MyFontWeight.regular,
        fontSize: this.fontSize,
      );

  TextStyle get medium => MyTextStyle.baseText(
        fontWeight: MyFontWeight.medium,
        fontSize: this.fontSize,
      );

  TextStyle get semiBold => MyTextStyle.baseText(
        fontWeight: MyFontWeight.semiBold,
        fontSize: this.fontSize,
      );

  TextStyle get bold => MyTextStyle.baseText(
        fontWeight: MyFontWeight.bold,
        fontSize: this.fontSize,
      );

  TextStyle get extraBold => MyTextStyle.baseText(
        fontWeight: MyFontWeight.extraBold,
        fontSize: this.fontSize,
      );

  TextStyle get ultraBold => MyTextStyle.baseText(
        fontWeight: MyFontWeight.ultraBold,
        fontSize: this.fontSize,
      );
}

extension TextStyleHelpers on TextStyle {
  // Color helpers
  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withOpacity(double opacity) {
    return copyWith(
      color: color?.withOpacity(opacity) ?? Colors.black.withOpacity(opacity),
    );
  }
}
