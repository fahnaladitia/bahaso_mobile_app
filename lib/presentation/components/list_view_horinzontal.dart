import 'package:flutter/material.dart';

class ListViewHorizontal extends StatelessWidget {
  final int itemCount;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final Widget? Function(BuildContext context, int index)? separatorBuilder;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final CrossAxisAlignment axisAlignment;
  final CrossAxisAlignment separatorAxisAlignment;
  const ListViewHorizontal({
    Key? key,
    required this.itemCount,
    this.physics,
    this.controller,
    this.padding,
    this.separatorBuilder,
    required this.itemBuilder,
    this.axisAlignment = CrossAxisAlignment.center,
    this.separatorAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: physics,
      controller: controller,
      padding: padding,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: axisAlignment,
        children: itemCount <= 0
            ? []
            : List.generate(
                itemCount,
                (index) {
                  if (separatorBuilder != null) {
                    if (index != 0) {
                      return Row(
                        crossAxisAlignment: separatorAxisAlignment,
                        children: [
                          separatorBuilder!(context, index) ?? const SizedBox.shrink(),
                          itemBuilder(context, index) ?? const SizedBox.shrink(),
                        ],
                      );
                    }
                  }
                  return itemBuilder(context, index) ?? const SizedBox.shrink();
                },
              ),
      ),
    );
  }
}
