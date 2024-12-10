import 'package:flutter/material.dart';
import 'package:todo_app/utils.dart' as u;

class BodyContainer extends StatelessWidget {
  const BodyContainer({super.key, required this.width, required this.child});
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: width * .02),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: width * .02),
      decoration: BoxDecoration(
          boxShadow: u.getBoxShadowOfTitle(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
