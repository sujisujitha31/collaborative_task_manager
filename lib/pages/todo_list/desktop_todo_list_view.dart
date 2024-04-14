import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';

import 'mobile_todo_list_view.dart';
import 'package:todo_app/utils.dart' as u;

class DesktopTodoListView extends GetView<TodoListController> {
  const DesktopTodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    print("inside DesktopTodoListView");
    double parentWidth = MediaQuery.of(context).size.width * .83;
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        // SizedBox(
        //   height: h,
        //   child: VerticalDivider(),
        // ),

        Container(
          margin: EdgeInsets.all(10),
          width: parentWidth * .6,
          height: h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              u.vFill(20),
              u.TextWithDmSans(
                text:
                    "Tasks under ${u.getFullDate(controller.selectedDate.value)}",
                fontSize: 18,
                weight: FontWeight.w700,
              ),
              u.vFill(20),
              GetBuilder<TodoListController>(builder: (cont) {
                if (cont.isGettingTodos.value) {
                  return Center(child: CircularProgressIndicator()
                      // SpinKitCircle(color:Colors.blue.shade100),
                      );
                } else if (!cont.isGettingTodos.value &&
                    cont.todoList.isEmpty) {
                  return Center(
                    child: u.TextWithDmSans(text: "There is no todo "),
                  );
                } else {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: controller.todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          border: Border.all(color: violetLight, width: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: u.getBoxShadow()
                        ),
                        child: Column(
                          children: [
                            u.vFill(5),
                            u.TextWithDmSans(
                              text:
                                  "${u.getTimeWithAmPmFormat(DateTime.parse(cont.todoList[index].dateTime!))} TO ${u.getTimeWithAmPmFormat(DateTime.parse(cont.todoList[index].dateTime!))}",
                            ),
                            u.vFill(5),
                            Divider(
                              color: violet,
                            ),
                            u.vFill(5),
                            u.TextWithDmSans(
                              text: controller.todoList[index].title!,
                              maxLine: 2,
                              weight: FontWeight.w700,
                            ),
                            u.vFill(5),
                            u.TextWithDmSans(
                              text: cont.todoList[index].description!,
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
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            NavigationCalendar(
              h: h,
              w: parentWidth * .3,
              today: DateTime.now(),
            ),
          ]),
        )
      ],
    );
  }
}
