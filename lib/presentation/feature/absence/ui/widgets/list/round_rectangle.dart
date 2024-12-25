import 'package:flutter/material.dart';

class RoundedRectangle extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const RoundedRectangle({
    super.key,
    this.height = 20,
    this.width = double.maxFinite, this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(radius),
        ));
  }
}