import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart' as c;
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/pages/add_item/widgets/collaboration_widget.dart';
import 'package:todo_app/pages/add_item/widgets/priority_row.dart';
import 'package:todo_app/pages/add_item/widgets/tap_calendar.dart';
import 'package:todo_app/pages/add_item/widgets/title_and_description_fields.dart';
import 'package:todo_app/utils.dart' as u;

import 'add_item_view.dart';

class DesktopAddITemView extends GetView<AddItemController> {
  const DesktopAddITemView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * .8;
    double h = MediaQuery.of(context).size.height;
    return AddItemBodyWidget(w: w, controller: controller, h: h);
  }
}

class AddItemBodyWidget extends StatelessWidget {
  const AddItemBodyWidget({
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
    return Column(
      children: [
        // u.vFill(20),
        SizedBox(
          width: w,
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              FillUpWidget(w: w * .5, controller: controller, h: h),
              const Spacer(),
              DetailsBoard(w: w * .4, controller: controller),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsBoard extends StatelessWidget {
  const DetailsBoard({
    super.key,
    required this.w,
    required this.controller,
  });

  final double w;
  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: w * .05),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)
          //  BorderRadius.only(
          //     topLeft: Radius.circular(40),
          //     bottomLeft: Radius.circular(40))
          ),
      width: w,
      child: controller.showDetails()
          ? Column(
              children: [
                u.vFill(30),
                Row(
                  children: [
                    SizedBox(
                      width: w * .27,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(330 / 360),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: u.TextWithDmSans(
                              text:
                                  u.getFullDate(controller.selectedDate.value),
                              maxLine: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: w * .35,
                      child: Center(
                        child: u.TextWithDmSans(
                          text: "My board",
                          color: c.purpleTheme,
                          fontSize: 18,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: w * .2,
                    )
                  ],
                ),
                u.vFill(20),
                u.TextWithDmSans(
                  text: "i am gonna do ${controller.titleController.text}",
                  fontSize: 15,
                  weight: FontWeight.w500,
                ),
                u.vFill(20),
                u.TextWithDmSans(
                  text: "details",
                  color: c.purpleTheme,
                  weight: FontWeight.w500,
                ),
                u.vFill(2),
                u.TextWithDmSans(
                  text: controller.descriptionController.text,
                  maxLine: 4,
                  textalign: TextAlign.center,
                ),
                u.vFill(20),
                u.TextWithDmSans(
                  text: "i want to share this with",
                  color: c.purpleTheme,
                  weight: FontWeight.w500,
                ),
                controller.selectedCollabNames.isEmpty
                    ? const u.TextWithDmSans(
                        text: "No body",
                      )
                    : const SizedBox(),
                for (int i = 0; i < controller.selectedCollabNames.length; i++)
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 25, height: 20,
                        // padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: u.TextWithDmSans(
                            text: (i + 1).toString(),
                          ),
                        ),
                      ),
                      u.TextWithDmSans(
                        text: controller.selectedCollabNames[i],
                      ),
                    ],
                  )
              ],
            )
          : const SizedBox(),
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
        height: h * .95,
        margin: EdgeInsets.symmetric(vertical: h * .02),
        padding: EdgeInsets.symmetric(horizontal: w * .0250),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)
            //  BorderRadius.only(
            //     topLeft: Radius.circular(40), bottomLeft: Radius.circular(40))
            ),
        width: w,
        // height: h,
        child: SingleChildScrollView(
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
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  for (int i = 0;
                      i < controller.selectedCollabNames.length;
                      i++)
                    SizedBox(
                      width: w * .3,
                      child: Row(
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
                            maxLine: 3,
                          ),
                          u.hFill(10),
                        ],
                      ),
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
