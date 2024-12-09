import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/pages/splash/splash_controller.dart';
import 'package:todo_app/utils.dart' as u;

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    Future.delayed(const Duration(seconds: 3), () async {
      controller.checkUserLoggedInOrNot();
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [violetLight, violet],
        )),
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * .5,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: u.TextWithDmSans(
                      text: "MY",
                      fontSize: 50,
                      weight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width * .53,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: u.TextWithDmSans(
                        text: "TODO",
                        fontSize: 50,
                        weight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            u.vFill(20),
          ],
        ),
      ),
    );
  }
}
