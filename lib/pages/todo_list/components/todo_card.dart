import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;
import '../todo_list_controller.dart';

class LoadingWidgetOrListWidgetOfTodos extends GetView<TodoListController> {
  const LoadingWidgetOrListWidgetOfTodos({
    super.key,
    required this.h,
    required this.today,
    required this.w,
  });

  final double h;
  final DateTime today;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.only(top: h * .03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<TodoListController>(builder: (cont) {
                return controller.isGettingTodos.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: violet,
                      ))
                    : TodoList(
                        controller: controller,
                        w: w,
                        h: h,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.controller,
    required this.w,
    required this.h,
  });

  final TodoListController controller;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return controller.todoList.isEmpty
        ? SizedBox(
            height: h * .8,
            child: const Center(
                child: u.PoppinsText(
              text: "There are no Todos here",
              fontSize: 17,
              weight: FontWeight.w500,
            )),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    EdgeInsets.only(bottom: 5, left: w * .02, right: w * .02),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 20, left: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: Checkbox(
                        side: BorderSide(color: violet, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        activeColor: violet,
                        checkColor: Colors.white,
                        value: controller.todoList[index].status ?? false,
                        onChanged: (value) {
                          controller.showConfirmStatus(
                              controller.todoList[index], value!);
                        },
                      ),
                    ),*/
                    SizedBox(
                      width: w * .2,
                    ),
                    SizedBox(
                      // color: Colors.amber,
                      width: w * .5,
                      child: u.PoppinsText(
                        text: controller.todoList[index].title ?? "--",
                        fontSize: 17,
                        weight: FontWeight.w500,
                        decoration: controller.todoList[index].status!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: violet,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          );
  }
}
