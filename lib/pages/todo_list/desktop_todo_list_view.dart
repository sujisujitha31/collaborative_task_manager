import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/globals.dart' as g;
import 'mobile_todo_list_view.dart';
import 'package:todo_app/utils.dart' as u;

class DesktopTodoListView extends GetView<TodoListController> {
  const DesktopTodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    print("inside DesktopTodoListView");
    double parentWidth = MediaQuery.of(context).size.width * .83;
    double h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: h * .15,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: u.TextWithDmSans(
                    text:
                        "Tasks under ${u.getFullDate(controller.selectedDate.value)}",
                    fontSize: 18,
                    weight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  maxRadius: 25,
                  minRadius: 25,
                  backgroundColor: orangeTheme,
                  // purpleTheme,
                  //  Color(0xc48894),
                  child: u.TextWithDmSans(
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
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: h,
            //   child: VerticalDivider(),
            // ),

            Container(
              margin: const EdgeInsets.all(10),
              width: parentWidth * .6,
              // height: h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<TodoListController>(builder: (cont) {
                    if (cont.isGettingTodos.value) {
                      return const Center(child: CircularProgressIndicator()
                          // SpinKitCircle(color:Colors.blue.shade100),
                          );
                    } else if (!cont.isGettingTodos.value &&
                        cont.todoList.isEmpty) {
                      return SizedBox(
                        height: h * .5,
                        child:
                            const u.TextWithDmSans(text: "There is no todo "),
                      );
                    } else {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: controller.todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffe7e7f3),
                              border:
                                  Border.all(color: violetLight, width: 0.2),
                              borderRadius: BorderRadius.circular(10),
                              // boxShadow: u.getBoxShadow()
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  maxLine: 3,
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
            ),
            const Spacer(),
            Container(
              height: h * .85,
              // color: Colors.white,
              decoration: BoxDecoration(
                  boxShadow: u.getBoxShadow(),
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(40))),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                NavigationCalendar(
                  // h: h,/
                  w: parentWidth * .3,
                  today: DateTime.now(),
                ),
              ]),
            )
          ],
        ),
      ],
    );
  }
}
