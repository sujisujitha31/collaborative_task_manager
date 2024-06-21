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

class DesktopAddITemView extends GetView<AddItemController> {
  const DesktopAddITemView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * .8;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        u.vFill(20),
        Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            FillUpWidget(w: w * .5, controller: controller, h: h),
            const Spacer(),
            Container(
              width: w * .5,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

class FillUpWidget extends StatelessWidget {
  const FillUpWidget({
    super.key,
    required this.w,
    required this.controller,
    required this.h,
  });

  final double w;
  final AddItemController controller;
  final double h;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddItemController>(builder: (cont) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: w * .0250),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        width: w,
        height: h * .9,
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    u.hFill(w * .02),
                    u.TextWithDmSans(
                      text: "Create New Task",
                      fontSize: 18,
                      weight: FontWeight.w500,
                      color: c.purpleTheme,
                    ),
                  ],
                ),
              ),
              getSizedBox(w * .95, "Title", TitleField(controller: controller)),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Description",
                DescriptionField(
                  controller: controller,
                ),
              ),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Collab-with",
                CollaborationWidget(
                  w: w * .95,
                  controller: controller,
                ),
              ),
              u.vFill(10),
              if (controller.selectedCollabNames.isNotEmpty)
                const u.TextWithDmSans(
                  text: "The task is also visible for:",
                ),
              if (controller.selectedCollabNames.isNotEmpty) u.vFill(10),
              Row(
                children: [
                  for (int i = 0;
                      i < controller.selectedCollabNames.length;
                      i++)
                    Row(
                      children: [
                        CircleAvatar(
                            maxRadius: 20,
                            child: u.TextWithDmSans(
                              text: controller.selectedCollabNames[i][0]
                                  .toUpperCase(),
                              weight: FontWeight.w500,
                            )),
                        u.hFill(10),
                        u.TextWithDmSans(
                          text: controller.selectedCollabNames[i],
                        ),
                        u.hFill(10),
                      ],
                    )
                ],
              ),
              if (controller.selectedCollabNames.isNotEmpty) u.vFill(10),
              getSizedBox(
                w * .95,
                "Date",
                TapCalendar(
                  controller: controller,
                  h: h,
                  w: w,
                ),
              ),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Priority",
                PriorityRow(
                  controller: controller,
                ),
              ),
              u.vFill(20),
              SizedBox(
                width: w * .95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            backgroundColor: c.purpleTheme),
                        onPressed: () {
                          controller.createTask();
                        },
                        child: const u.TextWithDmSans(
                          text: "Create",
                          color: Colors.white,
                          fontSize: 16,
                          weight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              u.vFill(15)
            ],
          ),
        ),
      );
    });
  }
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
