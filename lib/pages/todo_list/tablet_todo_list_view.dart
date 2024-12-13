import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/todo_list/desktop_todo_list_view.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';

class TabletTodoListView extends GetView<TodoListController> {
  const TabletTodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return TaskListBody(h: h, controller: controller, parentWidth: parentWidth);
  }
}
