import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/pages/todo_list/mobile_todo_list_view.dart';
import 'package:todo_app/pages/todo_list/tablet_todo_list_view.dart';
import 'package:todo_app/utils.dart';

import '../add_item/desktop_add_item.dart';
import '../todo_list/desktop_todo_list_view.dart';

class SideMenuController extends GetxController {
  var selectedPage = 0.obs;
  goToPage(int index, {BuildContext? context}) {
    selectedPage.value = index;
    if (selectedPage.value == menuTitles.length - 1) {
      showLogoutPopup();
    }
    if (selectedPage.value == 1) {
      double w = MediaQuery.of(context!).size.width * .5;
      double h = MediaQuery.of(context).size.height;
      showAddItemDialog(h, w);
    }

    update();
  }

  List<String> menuTitles = ["Tasks", "Add task", "Profile", "Logout"];
  List<IconData> icons = [
    Icons.task,
    Icons.add_circle_rounded,
    Icons.person,
    Icons.logout
  ];
  Map desktopPages = {
    0: const DesktopTodoListView(),
    1: const DesktopTodoListView(),
    2: SizedBox(),
    3: SizedBox()
  };
  Map tabletPages = {
    0: const TabletTodoListView(),
    1: const TabletTodoListView(),
    2: SizedBox(),
    3: SizedBox()
  };
  Map mobilePages = {
    0: MobileTodoListView(),
    1: MobileTodoListView(),
    2: SizedBox(),
    3: SizedBox()
  };
}

showLogoutPopup() {
  return Get.defaultDialog(
      title: "Confirmation",
      content: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: TextWithDmSans(text: "Are you sure want to logout?"),
      ),
      actions: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: BorderSide(
                  color: violet,
                )),
            onPressed: () {
              Get.back();
            },
            child: TextWithDmSans(
              text: "Cancel",
              weight: FontWeight.w700,
              color: violet,
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: violet),
            onPressed: () {
              Get.find<LoginController>().onLogout();
            },
            child: const TextWithDmSans(
              text: "Sure",
              weight: FontWeight.w700,
              color: Colors.white,
            ))
      ]);
}
