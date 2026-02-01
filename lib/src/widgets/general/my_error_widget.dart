import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/widgets/general/my_sized_box.dart';

class MyErrorWidget extends StatelessWidget {
  final String? message;
  MyErrorWidget(this.message);
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          MySizedBox.smallVertical(),
          Icon(
            Icons.error,
            size: 60.sp,
            color: MyColor.red,
          ),
          MySizedBox.extraSmallVertical(),
          Text(
            message ?? '',
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          MySizedBox.smallVertical(),
        ],
      ),
    );
  }
}
