import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/login/mobile_login_view.dart';
import 'package:todo_app/responsive.dart';

import '../../responsive_base_screen.dart';
import '../login/desktop_login_view.dart';
import 'package:todo_app/globals.dart' as g;

import '../login/login_controller.dart';
import '../todo_list/todo_list_controller.dart';

class SplashController extends GetxController {
  checkUserLoggedInOrNot() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => const Responsive(
            desktopScaffold: DesktopLoginView(),
            tabletScaffold: SizedBox(),
            mobileScaffold: LoginView()));
      } else {
        g.setAuthDetails(user.email!);
        getInitialValues();
        Get.offAll(() => const ResponsiveBaseScreen());
      }
    });
  }

  getInitialValues() {
    Get.find<LoginController>().getCollabarators();
    final todoController = Get.find<TodoListController>();
    todoController.searchByToday();
    todoController.getTodos();
  }
}
