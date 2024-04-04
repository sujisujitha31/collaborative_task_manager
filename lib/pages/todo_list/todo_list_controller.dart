import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/model/todo_model.dart';
import '../../firebase/firebase_database.dart';
import 'package:todo_app/utils.dart' as u;

class TodoListController extends GetxController {
  var isCalendarOpened = false.obs;
  var isGettingTodos = false.obs;
  RxInt selectedTodo = RxInt(-1);
  var todoList = <TodoModel>[].obs;
  var selectedDate = DateTime.now().obs;
  String searchFromRange = "";
  String searchToRange = "";

  void openTheCalendar() {
    isCalendarOpened.value = true;
    // isCalendarOpened.value = !isCalendarOpened.value;
    update();
  }

  void closeCalendar() {
    isCalendarOpened.value = false;
    // isCalendarOpened.value = !isCalendarOpened.value;
    update();
  }

  selectDate(DateTime date) {
    selectedDate.value = date;
    searchByAnyDay(selectedDate.value, selectedDate.value);
    update();
    getTodos();
    isCalendarOpened.value = false;
    update();
  }

  searchByToday() {
    DateTime today = DateTime.now();
    searchFromRange = DateTime(today.year, today.month, today.day)
        .microsecondsSinceEpoch
        .toString();
    searchToRange = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: 1))
        .microsecondsSinceEpoch
        .toString();
  }

  searchByAnyDay(DateTime startDate, DateTime endDate) {
    searchFromRange = DateTime(startDate.year, startDate.month, startDate.day)
        .microsecondsSinceEpoch
        .toString();
    searchToRange = DateTime(endDate.year, endDate.month, endDate.day)
        .add(const Duration(days: 1))
        .microsecondsSinceEpoch
        .toString();
  }

  getTodos() async {
    selectedTodo.value = -1;
    isGettingTodos.value = true;

    todoList.value =
        await FirebaseDatabase().readData(searchFromRange, searchToRange);
    isGettingTodos.value = false;
    update();
  }

  makeDone(bool isDone, TodoModel todo) async {
    u.showLoading("Updating");
    todo.status = isDone;
    FirebaseDatabase().updateData(todo).then((value) {
      u.closeLoading();
      Get.back();
      getTodos();
    });
  }

  showConfirmStatus(TodoModel todo, bool isDone) {
    return Get.defaultDialog(
        // backgroundColor: ,
        title: "Confirmation",
        content: u.TextWithDmSans(
          text: "Are you sure to mark this ${todo.status! ? "Done" : "Undone"}",
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(side: BorderSide(color: violet)),
              onPressed: () {
                Get.back();
              },
              child: u.TextWithDmSans(text: "No", color: violet)),
          u.hFill(20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: violet),
              onPressed: () {
                makeDone(isDone, todo);
              },
              child: u.TextWithDmSans(
                text: "Yes",
              ))
        ]);
  }

  List<Color> colors = [
    Colors.amber.withOpacity(0.2),
    Colors.pink.withOpacity(0.2),
    Colors.cyan.withOpacity(0.2),
    Colors.green.withOpacity(0.2),
    Colors.deepOrange.withOpacity(0.2),
    Colors.blueGrey.withOpacity(0.2),
    Colors.indigo.withOpacity(0.2)
  ];
  List<Color> dimColors = [
    Colors.amber.withOpacity(0.1),
    Colors.pink.withOpacity(0.1),
    Colors.cyan.withOpacity(0.1),
    Colors.green.withOpacity(0.1),
    Colors.deepOrange.withOpacity(0.1),
    Colors.blueGrey.withOpacity(0.1),
    Colors.indigo.withOpacity(0.1)
  ];
  List<Color> getColors() {
    int random = Random().nextInt(6);
    return [colors[random], dimColors[random]];
  }
}
