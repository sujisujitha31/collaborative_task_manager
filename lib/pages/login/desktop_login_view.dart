import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart' as c;
import 'package:todo_app/pages/login/login_controller.dart';
import 'mobile_login_view.dart';

class DesktopLoginView extends GetView<LoginController> {
  const DesktopLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    print("desktop view");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width * .83;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: width * .5,
              color: c.violet,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: w * .4,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  LoginBody(
                    height: h * .8,
                    width: w * .3,
                    controller: controller,
                  ),
                  const Spacer(),
                  SignUpWidgets(width: w * .3, height: h * .8),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
          ],
        ));
  }
}
