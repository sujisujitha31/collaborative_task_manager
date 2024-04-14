import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart' as c;
import 'package:todo_app/pages/login/login_controller.dart';

import 'mobile_login_view.dart';

class DesktopLoginView extends GetView<LoginController> {
  const DesktopLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width * .83;
    return Scaffold(
        backgroundColor: c.violet,
        body: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin:
                  EdgeInsets.only(left: w * .15, top: h * .07, bottom: h * .07),
              width: w * .4,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginBody(
                    height: h * .95,
                    width: w * .3,
                    controller: controller,
                  ),
                  const Spacer(),
                  SignUpWidgets(width: w * .3, height: h * .95)
                ],
              ),
            ),
            Container()
          ],
        ));
  }
}
