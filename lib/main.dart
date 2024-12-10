import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/base_screen/base_screen_controller.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/pages/splash/splash_controller.dart';

import 'firebase_options.dart';
import 'pages/add_item/add_item_controller.dart';
import 'pages/menu/navigation_controller.dart';
import 'pages/splash/splash_screen.dart';
import 'pages/todo_list/todo_list_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(SplashController());
  Get.put(BaseScreenController());
  Get.put(SideMenuController());
  Get.put(AddItemController());
  Get.put(TodoListController());
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashView(),
    );
  }
}
