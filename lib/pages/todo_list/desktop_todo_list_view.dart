import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/body_title.dart';
import 'package:todo_app/components/crud_components.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/globals.dart' as g;
import 'package:todo_app/responsive.dart';
import 'mobile_todo_list_view.dart';
import 'package:todo_app/utils.dart' as u;
import "package:todo_app/constant.dart" as c;

class DesktopTaskListView extends GetView<TodoListController> {
  const DesktopTaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width * .83;
    double h = MediaQuery.of(context).size.height;
    return TaskListBody(h: h, controller: controller, parentWidth: parentWidth);
  }
}

class TaskListBody extends StatelessWidget {
  const TaskListBody({
    super.key,
    required this.h,
    required this.controller,
    required this.parentWidth,
  });

  final double h;
  final TodoListController controller;
  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyTitle(
          title: "Tasks under ${u.getFullDate(controller.selectedDate.value)}",
          rightsideWidget: Row(
            children: [RefreshButton(callBack: () {})],
          ),
        ),
        u.vFill(20),
        SizedBox(
          width: parentWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskList(parentWidth: parentWidth, h: h, controller: controller),
              const Spacer(),
              Calendar(h: h, parentWidth: parentWidth)
            ],
          ),
        ),
      ],
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.h,
    required this.parentWidth,
  });

  final double h;
  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // height: double.infinity,
      height: h * .6,
      // color: Colors.white,
      decoration: BoxDecoration(
          boxShadow: u.getBoxShadow(),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        NavigationCalendar(
          // h: h,/
          w: parentWidth * .3,
          today: DateTime.now(),
        ),
      ]),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.parentWidth,
    required this.h,
    required this.controller,
  });

  final double parentWidth;
  final double h;
  final TodoListController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: parentWidth * .5,
      // height: h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<TodoListController>(builder: (cont) {
            if (cont.isGettingTodos.value) {
              return const Center(child: CircularProgressIndicator()
                  // SpinKitCircle(color:Colors.blue.shade100),
                  );
            } else if (!cont.isGettingTodos.value && cont.todoList.isEmpty) {
              return SizedBox(
                height: h * .5,
                child: const u.PoppinsText(text: "No tasks found"),
              );
            } else {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: controller.todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffe7e7f3),
                      border: Border.all(color: violetLight, width: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: u.getBoxShadow()
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        u.vFill(5),
                        u.PoppinsText(
                          text:
                              "${u.getTimeWithAmPmFormat(DateTime.parse(cont.todoList[index].dateTime!))} TO ${u.getTimeWithAmPmFormat(DateTime.parse(cont.todoList[index].dateTime!))}",
                        ),
                        u.vFill(5),
                        Divider(
                          color: violet,
                        ),
                        u.vFill(5),
                        u.PoppinsText(
                          text: controller.todoList[index].title!,
                          maxLine: 1,
                          weight: FontWeight.w700,
                        ),
                        u.vFill(5),
                        u.PoppinsText(
                          text: cont.todoList[index].description!,
                          maxLine: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.h,
    required this.controller,
    required this.parentWidth,
  });

  final double h;
  final TodoListController controller;
  final double parentWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * .1,
      width: parentWidth,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: u.PoppinsText(
                text:
                    "Tasks under ${u.getFullDate(controller.selectedDate.value)}",
                fontSize: 18,
                weight: FontWeight.w700,
                color: c.appColor,
              ),
            ),
            const Spacer(),
            if (Responsive.isDesktop(context))
              CircleAvatar(
                maxRadius: 25,
                minRadius: 25,
                backgroundColor: orangeTheme,
                child: u.PoppinsText(
                  text: g.userMail[0],
                  weight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            u.hFill(10),
          ],
        ),
      ),
    );
  }
}
