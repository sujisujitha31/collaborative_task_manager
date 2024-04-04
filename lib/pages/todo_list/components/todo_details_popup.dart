import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart' as u;

showTaskDetails(double w, TodoListController controller, int index) {
  return Get.dialog(Material(
    type: MaterialType.transparency,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: w * .8,
                  decoration: BoxDecoration(
                      color: controller.todoList[index].type == "todo"
                          ? todoColor
                          : routinecolor),
                  child: Center(
                    child: Row(children: [
                      const Spacer(),
                      u.TextWithDmSans(
                        text: controller.todoList[index].title ?? "--",
                        fontSize: 15,
                        weight: FontWeight.w500,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close))
                    ]),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  width: w * .8,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      u.TextWithDmSans(
                          text:
                              controller.todoList[index].description ?? "-..."),
                      u.vFill(10),
                      Row(
                        children: [
                          const u.TextWithDmSans(
                            text: "Date:   ",
                          ),
                          u.TextWithDmSans(
                            text: u.getFullDate(DateTime.now()),
                            weight: FontWeight.w500,
                          )
                        ],
                      ),
                      u.vFill(10),
                      Row(
                        children: [
                          const u.TextWithDmSans(
                            text: "Time:   ",
                          ),
                          u.TextWithDmSans(
                            text: u.getFullDate(DateTime.now()),
                            weight: FontWeight.w500,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    ),
  ));
}
