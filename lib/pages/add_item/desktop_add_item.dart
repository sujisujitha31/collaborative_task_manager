import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart' as c;
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/pages/add_item/widgets/collaboration_widget.dart';
import 'package:todo_app/pages/add_item/widgets/priority_row.dart';
import 'package:todo_app/pages/add_item/widgets/tap_calendar.dart';
import 'package:todo_app/pages/add_item/widgets/tap_time.dart';
import 'package:todo_app/pages/add_item/widgets/title_and_description_fields.dart';
import 'package:todo_app/utils.dart' as u;

import 'add_item_view.dart';

showAddItemDialog(double h, double w) {
  final controller = Get.find<AddItemController>();
  return Get.dialog(Material(
    type: MaterialType.transparency,
    child: Center(
      // mainAxisSize: MainAxisSize.min,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          width: w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10,
                decoration: BoxDecoration(
                    color: c.purpleTheme,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                height: 70,
                child: Row(
                  children: [
                    const Spacer(),
                    const u.TextWithDmSans(
                      text: "Create New Task",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    u.hFill(10)
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    /* Row(
                      children: [
                        const Spacer(),
                        getSizedBox(w * .45, "Title",
                            TitleField(controller: controller)),
                        const Spacer(),
                        getSizedBox(w * .45, "Time", TapTime(w * .45)),
                        const Spacer(),
                      ],
                    ),*/
                    getAddItemSingleRow(
                      getSizedBox(
                          w * .45, "Title", TitleField(controller: controller)),
                      getSizedBox(w * .45, "Time", TapTime(w * .45)),
                    ),
                    u.vFill(10),
                    /* Row(
                      children: [
                        const Spacer(),
                        getSizedBox(
                          w * .45,
                          "Description",
                          DescriptionField(
                            controller: controller,
                          ),
                        ),
                        const Spacer(),
                        getSizedBox(
                          w * .45,
                          "Collab-with",
                          CollaborationWidget(
                            w: w * .45,
                            controller: controller,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),*/
                    u.vFill(10),
                    getAddItemSingleRow(
                      getSizedBox(
                        w * .45,
                        "Description",
                        DescriptionField(
                          controller: controller,
                        ),
                      ),
                      getSizedBox(
                        w * .45,
                        "Collab-with",
                        CollaborationWidget(
                          w: w * .45,
                          controller: controller,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        getSizedBox(
                          w * .45,
                          "Date",
                          TapCalendar(
                            controller: controller,
                            h: h,
                            w: w,
                          ),
                        ),
                        const Spacer(),
                        getSizedBox(
                          w * .45,
                          "Priority",
                          PriorityRow(
                            controller: controller,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    u.vFill(20),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                backgroundColor: c.purpleTheme),
                            onPressed: () {},
                            child: const u.TextWithDmSans(
                              text: "Create",
                              color: Colors.white,
                              fontSize: 16,
                              weight: FontWeight.w500,
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    ),
  ));
}

getSizedBox(double w, String title, Widget child) {
  return SizedBox(
    width: w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [getHeading(title), child],
    ),
  );
}

getAddItemSingleRow(Widget w1, Widget w2) {
  return Row(
    children: [
      const Spacer(),
      w1,
      const Spacer(
        flex: 2,
      ),
      w2,
      const Spacer()
    ],
  );
}
