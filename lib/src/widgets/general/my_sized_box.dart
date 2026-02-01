import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySizedBox extends StatelessWidget {
  final double? width;
  final double? height;

  static double separatorDefault = 16.w;

  static double separatorDefaultSmall = 10.w;

  MySizedBox({this.width, this.height});

  MySizedBox.bloodyLargeVertical({this.width = 0, this.height = 55});

  MySizedBox.ultraLargeVertical({this.width = 0, this.height = 45});

  MySizedBox.extraLargeVertical({this.width = 0, this.height = 35});

  MySizedBox.largeVertical({this.width = 0, this.height = 30});

  MySizedBox.normalVertical({this.width = 0, this.height = 25});

  MySizedBox.smallVertical({this.width = 0, this.height = 20});

  MySizedBox.lessExtraSmallVertical({this.width = 0, this.height = 15});

  MySizedBox.extraSmallVertical({this.width = 0, this.height = 10});

  MySizedBox.extraMiddleSmallVertical({this.width = 0, this.height = 8});

  MySizedBox.ultraSmallVertical({this.width = 0, this.height = 5});

  MySizedBox.bloodySmallVertical({this.width = 0, this.height = 3});

  MySizedBox.bloodyLargeHorizontal({this.width = 55, this.height = 0});

  MySizedBox.ultraLargeHorizontal({this.width = 45, this.height = 0});

  MySizedBox.extraLargeHorizontal({this.width = 35, this.height = 0});

  MySizedBox.largeHorizontal({this.width = 30, this.height = 0});

  MySizedBox.normalHorizontal({this.width = 25, this.height = 0});

  MySizedBox.smallHorizontal({this.width = 20, this.height = 0});

  MySizedBox.lessExtraSmallHorizontal({this.width = 15, this.height = 0});

  MySizedBox.extraSmallHorizontal({this.width = 10, this.height = 0});

  MySizedBox.ultraSmallHorizontal({this.width = 5, this.height = 0});

  MySizedBox.bloodySmallHorizontal({this.width = 3, this.height = 0});

  MySizedBox.listSeparator()
      : width = separatorDefault,
        height = separatorDefault;

  MySizedBox.listSeparatorSmall()
      : width = separatorDefaultSmall,
        height = separatorDefaultSmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  width,
      height: height,
    );
  }
}
