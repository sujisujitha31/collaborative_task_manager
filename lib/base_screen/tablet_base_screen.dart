import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'desktop_base_screen.dart';

class TabletBaseScreen extends StatelessWidget {
  const TabletBaseScreen({
    Key? key,
  }) : super(key: key);

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [buildDrawer(context), buildBodyContent(context)],
    );
  }

  buildDrawer(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * .15,
    );
  }

// this is content area
  buildBodyContent(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * .85,
    );
  }

  buildBodyScreen(BuildContext context) {}
}
