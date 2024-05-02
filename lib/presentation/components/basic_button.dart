// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color fillColor;
  final Color? sideColor;
  final Color textColor;
  final double? width;
  final Widget? icon;
  final TextStyle? textStyle;
  const BasicButton._({
    super.key,
    required this.text,
    this.onPressed,
    required this.fillColor,
    this.sideColor,
    required this.textColor,
    this.width,
    this.icon,
    this.textStyle,
  });

  const BasicButton.primary({
    Key? key,
    required String text,
    void Function()? onPressed,
    Color? fillColor,
    double? width,
    Widget? icon,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          text: text,
          onPressed: onPressed,
          fillColor: fillColor ?? const Color(0xFF1FA0C9),
          textColor: Colors.white,
          width: width,
          icon: icon,
          textStyle: textStyle,
        );

  const BasicButton.secondary({
    Key? key,
    required String text,
    void Function()? onPressed,
    double? width,
    Widget? icon,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          text: text,
          onPressed: onPressed,
          fillColor: Colors.white,
          sideColor: const Color(0xFF1FA0C9),
          textColor: const Color(0xFF1FA0C9),
          width: width,
          icon: icon,
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: 43,
        child: icon != null
            ? FilledButton.icon(
                onPressed: onPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: fillColor,
                  foregroundColor: textColor,
                  textStyle: textStyle ?? Theme.of(context).textTheme.labelLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: sideColor != null ? BorderSide(color: sideColor!) : BorderSide.none,
                  ),
                  elevation: 0,
                  alignment: Alignment.center,
                ),
                icon: icon!,
                label: Text(text),
              )
            : FilledButton(
                onPressed: onPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: fillColor,
                  foregroundColor: textColor,
                  textStyle: textStyle ?? Theme.of(context).textTheme.labelLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: sideColor != null ? BorderSide(color: sideColor!) : BorderSide.none,
                  ),
                  elevation: 0,
                  alignment: Alignment.center,
                ),
                child: Text(text),
              ));
  }
}
