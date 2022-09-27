import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  MyButton(
      {Key? key,
        required this.child,
        this.onTap,
        this.hasShadow = false,
        this.height,
        this.width,
        this.hasDoubleShadow,
        this.borderRadius,
        this.horizontalPadding,
        this.verticalPadding,
        this.alignment,
        this.gradient,
        this.boxBorder,
        this.boxShadow,
        this.shape,
        this.icon,
        this.color})
      : super(key: key);

  final Widget child;
  final IconData? icon;
  final Function()? onTap;
  final Color? color;
  final bool? hasDoubleShadow;
  final bool? hasShadow;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxBorder? boxBorder;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Alignment? alignment;
  final LinearGradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 5),
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            // border: boxBorder ?? Border.all(color: controller.borderColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
            boxShadow: boxShadow ?? []),
        child: Center(child: child),
      ),
    );
  }
}
