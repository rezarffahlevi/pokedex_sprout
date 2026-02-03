import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  Widget child;
  Widget? shimmer;
  bool show;
  MyShimmer({required this.child, this.shimmer, this.show = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (show) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: shimmer ?? child,
    );
  }
}
