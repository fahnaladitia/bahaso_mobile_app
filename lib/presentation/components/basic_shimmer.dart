import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BasicShimmer extends StatelessWidget {
  final Widget shimmer;
  const BasicShimmer._({
    Key? key,
    required this.shimmer,
  }) : super(key: key);

  BasicShimmer.aspectRatio({
    Key? key,
    required double aspectRatio,
    BorderRadiusGeometry? borderRadius,
  }) : this._(
          key: key,
          shimmer: AspectRatio(
            aspectRatio: aspectRatio,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.zero),
            ),
          ),
        );

  BasicShimmer.size({
    Key? key,
    required double width,
    required double height,
    BorderRadiusGeometry? borderRadius,
  }) : this._(
          key: key,
          shimmer: SizedBox(
            width: width,
            height: height,
            child: const Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: shimmer,
    );
  }
}
