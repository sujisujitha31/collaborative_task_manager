import 'package:flutter/material.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/constant.dart' as c;

class BodyTitle extends StatelessWidget {
  const BodyTitle({
    super.key,
    required this.title,
    this.rightsideWidget = const SizedBox(),
  });
  final String title;
  final Widget rightsideWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            u.PoppinsText(
              text: title,
              fontSize: 18,
              weight: FontWeight.w600,
              color: Color(0Xff494949),
            ),
            const Spacer(),
            rightsideWidget
          ],
        ),
        u.vFill(15),
        SizedBox(
          height: 1,
          child: Divider(
            color: c.listDividerColor,
          ),
        ),
      ],
    );
  }
}
