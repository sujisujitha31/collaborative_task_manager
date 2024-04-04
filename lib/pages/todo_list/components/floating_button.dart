import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/login/login_controller.dart';

import '../../add_item/add_item_view.dart';

class FloatingWidget extends StatelessWidget {
  const FloatingWidget({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: h * .15,
        width: w * .18,
        child: FloatingActionButton(
            backgroundColor: violet,
            onPressed: () async {
              // Get.find<LoginController>().onLogout();
              Get.to(() => AddItemScreen(
                    w: w,
                    h: h,
                  ));
            },
            child: Text(
              String.fromCharCode(CupertinoIcons.add.codePoint),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w100,
                  fontFamily: CupertinoIcons.add.fontFamily,
                  package: CupertinoIcons.add.fontPackage),
            )));
  }
}
