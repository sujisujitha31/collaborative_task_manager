import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/pages/todo_list/mobile_todo_list_view.dart';
import 'package:todo_app/pages/todo_list/tablet_todo_list_view.dart';
import 'package:todo_app/utils.dart';

import '../add_item/desktop_add_item.dart';
import '../add_item/tablet_add_item.dart';
import '../todo_list/desktop_todo_list_view.dart';
import 'package:todo_app/constant.dart' as c;

class SideMenuController extends GetxController {
  var selectedPage = c.Constants.kMainMenuAddTask.obs;
  var previoulySelectedPage = "".obs;
  goToPage(String index, {BuildContext? context}) {
    previoulySelectedPage.value = selectedPage.value;
    selectedPage.value = index;
    if (selectedPage.value == c.Constants.kMainMenuLogout) {
      showLogoutPopup(() {
        selectedPage.value = previoulySelectedPage.value;
      });
    } else if (selectedPage.value == c.Constants.kMainMenuAddTask) {
      Get.find<AddItemController>().makeAllUnSelected();
    }

    update();
  }

  Map<String, String> menuTitles = {
    c.Constants.kMainMenuTask: "Tasks",
    c.Constants.kMainMenuAddTask: "Add task",
    c.Constants.kMainMenuProfile: "Profil",
    c.Constants.kMainMenuLogout: "Logout"
  };
  Map<String, String> icons = {
    c.Constants.kMainMenuTask:
        // Icons.task,
        "assets/icons/task.png",
    c.Constants.kMainMenuAddTask:
        // Icons.add_circle_rounded,
        "assets/icons/add.png",
    c.Constants.kMainMenuProfile: "assets/icons/profile.png",
    // Icons.person,
    c.Constants.kMainMenuLogout: "assets/icons/logout.png"
    // Icons.logout
  };
  Map desktopPages = {
    c.Constants.kMainMenuTask: const DesktopTaskListView(),
    c.Constants.kMainMenuAddTask: const DesktopAddTaskView(),
    c.Constants.kMainMenuProfile: const SizedBox(),
    c.Constants.kMainMenuLogout: const SizedBox()
  };
  Map tabletPages = {
    c.Constants.kMainMenuTask: const TabletTodoListView(),
    c.Constants.kMainMenuAddTask: const TabletAddITemView(),
    c.Constants.kMainMenuProfile: const SizedBox(),
    c.Constants.kMainMenuLogout: const SizedBox()
  };
  Map mobilePages = {
    c.Constants.kMainMenuTask: MobileTodoListView(),
    c.Constants.kMainMenuAddTask: const SizedBox(),
    c.Constants.kMainMenuProfile: const SizedBox(),
    c.Constants.kMainMenuLogout: const SizedBox()
  };
}

showLogoutPopup(Function() getBack) {
  return Get.defaultDialog(
      barrierDismissible: false,
      title: "Confirmation",
      content: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: PoppinsText(text: "Are you sure want to logout?"),
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
              getBack();
            },
            child: PoppinsText(
              text: "Cancel",
              weight: FontWeight.w700,
              color: violet,
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: violet),
            onPressed: () {
              Get.find<LoginController>().onLogout();
            },
            child: const PoppinsText(
              text: "Sure",
              weight: FontWeight.w700,
              color: Colors.white,
            ))
      ]);
}
