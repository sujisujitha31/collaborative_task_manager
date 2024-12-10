import 'package:flutter/material.dart';
import 'package:todo_app/utils.dart' as u;

class MandatoryTextWithchildWidget extends StatelessWidget {
  const MandatoryTextWithchildWidget({
    super.key,
    required this.width,
    required this.text,
    required this.child,
  });
  final double width;
  final Widget child;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          u.MandatoryText(
            text: text,
          ),
          u.vFill(10),
          child
        ],
      ),
    );
  }
}
