import 'dart:math';

import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BasicCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  const BasicCachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = min(constraints.maxHeight, constraints.maxWidth);
            return CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              color: color,
              errorWidget: (context, url, error) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius ?? 8) : null,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      size: size * 0.35,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                if (width != null && height != null) {
                  return BasicShimmer.size(
                    width: width!,
                    height: height!,
                    borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius ?? 8) : null,
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ));
  }
}
