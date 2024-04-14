import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'desktop_base_screen.dart';

class MobileBaseScreen extends StatelessWidget {
  const MobileBaseScreen({
    Key? key,
  }) : super(key: key);

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return buildBodyContent(context);
  }

  Widget buildBodyContent(BuildContext context) {
    return const SizedBox();
  }
}
