import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

import 'widgets/collaboration_widget.dart';
import 'widgets/priority_row.dart';
import 'widgets/tap_calendar.dart';
import 'widgets/tap_time.dart';
import 'widgets/title_and_description_fields.dart';

class AddItemScreen extends GetView<AddItemController> {
  const AddItemScreen({super.key, required this.h, required this.w});
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .05),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: u.TextWithDmSans(
                    text: "Add",
                    color: Colors.black,
                    fontSize: 35,
                    weight: FontWeight.w700,
                  ),
                ),
                u.vFill(h * .01),
                Center(
                  child: Container(
                    width: 50,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                u.vFill(h * .03),
                getHeading("Title"),
                TitleField(controller: controller),
                u.vFill(h * .02),
                getHeading("Description"),
                DescriptionField(
                  controller: controller,
                ),
                u.vFill(h * .02),
                getHeading("Date"),
                TapCalendar(
                  controller: controller,
                  h: h,
                  w: w,
                ),
                u.vFill(h * .02),
                getHeading("Time"),
                const TapTime(),
                u.vFill(h * .02),
                getHeading("Collab with"),
                CollaborationWidget(
                  w: w,
                  controller: controller,
                ),
                u.vFill(h * .02),
                ShareTaskListWidget(
                  controller: controller,
                ),
                getHeading("Priority"),
                PriorityRow(
                  controller: controller,
                ),
                u.vFill(h * .02),
                Center(
                  child: SizedBox(
                    width: w * .8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: violet,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            shadowColor: violet),
                        onPressed: () {
                          if (controller.validate()) {
                            controller.storeDataToDb();
                          }
                        },
                        child: const u.TextWithDmSans(
                          text: "Save",
                          fontSize: 17,
                          weight: FontWeight.w500,
                        )),
                  ),
                ),
                u.vFill(h * .02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getHeading(String str) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      u.TextWithDmSans(
        text: str,
        fontSize: 17,
        weight: FontWeight.w500,
      ),
      u.vFill(7),
      Container(
        height: 2,
        width: 20,
        color: Colors.black45,
      ),
      u.vFill(10),
    ],
  );
}

getDays(h, w) {
  List<Widget> days = [];
  for (int i = 1; i <= 31; i++) {
    days.add(SizedBox(
      width: w * .2,
      height: h * .08,
      child: Center(
          child: u.TextWithDmSans(
        text: i.toString(),
        fontSize: 20,
        weight: FontWeight.w500,
      )),
    ));
  }
  return days;
}

getMonths(h, w) {
  List<Widget> months = [];
  for (int i = 1; i <= 12; i++) {
    months.add(SizedBox(
        height: h * .08,
        width: w * .5,
        child: Center(
            child: u.TextWithDmSans(
                text: u.getMonthName(DateTime(2023, i, 12))))));
  }
  return months;
}

getYears(h, w) {
  List<Widget> months = [];
  for (int i = 1999; i <= 2050; i++) {
    months.add(SizedBox(
        height: h * .08,
        width: w * .5,
        child: Center(
            child: u.TextWithDmSans(
          text: i.toString(),
        ))));
  }
  return months;
}
