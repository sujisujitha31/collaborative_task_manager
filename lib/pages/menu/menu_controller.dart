import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/pages/todo_list/mobile_todo_list_view.dart';
import 'package:todo_app/pages/todo_list/tablet_todo_list_view.dart';
import 'package:todo_app/utils.dart';

import '../add_item/desktop_add_item.dart';
import '../todo_list/desktop_todo_list_view.dart';

class SideMenuController extends GetxController {
  var selectedPage = "task".obs;
  var previoulySelectedPage = "".obs;
  goToPage(String index, {BuildContext? context}) {
    previoulySelectedPage.value = selectedPage.value;
    selectedPage.value = index;
    if (selectedPage.value == "logout") {
      showLogoutPopup();
    } else if (selectedPage.value == "create-task") {
      Get.find<AddItemController>().makeAllUnSelected();
    }

    update();
  }

  Map<String, String> menuTitles = {
    "task": "Tasks",
    "create-task": "Add task",
    "profile": "Profile",
    "logout": "Logout"
  };
  Map<String, IconData> icons = {
    "task": Icons.task,
    "create-task": Icons.add_circle_rounded,
    "profile": Icons.person,
    "logout": Icons.logout
  };
  Map desktopPages = {
    "task": const DesktopTodoListView(),
    "create-task": const DesktopAddITemView(),
    "profile": const SizedBox(),
    "logout": const SizedBox()
  };
  Map tabletPages = {
    "task": const TabletTodoListView(),
    "create-task": const SizedBox(),
    "profile": const SizedBox(),
    "logout": const SizedBox()
  };
  Map mobilePages = {
    "task": MobileTodoListView(),
    "create-task": const SizedBox(),
    "profile": const SizedBox(),
    "logout": const SizedBox()
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
