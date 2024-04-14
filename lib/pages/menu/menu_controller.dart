import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/todo_list/mobile_todo_list_view.dart';
import 'package:todo_app/pages/todo_list/tablet_todo_list_view.dart';

import '../todo_list/desktop_todo_list_view.dart';

class SideMenuController extends GetxController {
  var selectedPage = 0.obs;
  goToPage(int index) {
    selectedPage.value = index;
  }

  List<String> menuTitles = ["Tasks", "Add task", "Profile", "Logout"];
  List<IconData> icons = [
    Icons.task,
    Icons.add_circle_rounded,
    Icons.person,
    Icons.logout
  ];
  Map desktopPages = {0: DesktopTodoListView()};
  Map tabletPages = {0: TabletTodoListView()};
  Map mobilePages = {0: MobileTodoListView()};
}
