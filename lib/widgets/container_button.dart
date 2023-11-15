import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton(
      {super.key,
      required this.title,
      required this.colorContainer,
      required this.paddingHorizontal,
      required this.titleStyle,
      required this.borderRadius,
      required this.paddingVertical,
      required this.margin});

  final String title;
  final TextStyle titleStyle;
  final Color colorContainer;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(color: colorContainer, borderRadius: BorderRadius.circular(borderRadius)),
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}
