import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

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
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.1),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                u.vFill(h * .02),
                getHeading("Description"),
                Obx(
                  () => Focus(
                    focusNode: controller.focus.value,
                    child: TextFormField(
                      onSaved: (value) {
                        controller.focus.value.unfocus();
                      },
                      onEditingComplete: () {
                        print("sjfbjds");
                      },
                      controller: controller.descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                          filled: true,
                          // fillColor: Colors.grey.shade200,
                          fillColor: Colors.blue.withOpacity(0.1),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                u.vFill(h * .02),
                getHeading("Date"),
                TapCalendarWidet(
                  controller: controller,
                  h: h,
                  w: w,
                ),
                u.vFill(h * .02),
                getHeading("Time"),
                TapTimeWidget(),
                u.vFill(h * .02),
                getHeading("Collab with"),
                Row(
                  children: [
                    SizedBox(
                      width: w * .7,
                      child: g.collabUsers.isEmpty
                          ? const u.TextWithDmSans(
                              text: "There is no collaboraters added yet")
                          : TextFormField(
                              readOnly: true,
                              onTap: () {
                                controller.showAddCollabPopup();
                              },
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.dmSans(),
                                  hintText: "Choose collaborators",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: violet)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: violet))),
                            ),
                    ),
                    SizedBox(
                        width: w * .2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {
                                controller.showDialogForAddCollaborator(w);
                              },
                              icon: const Icon(
                                Icons.add_circle_rounded,
                                color: Colors.green,
                                size: 40,
                              )),
                        )),
                  ],
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    g.collabUsers.isEmpty
                        ? const u.TextWithDmSans(
                            text: "There is no collaboraters added yet")
                        : SizedBox(
                            width: w * .45,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: DropdownButton(
                                value: controller.selectedCollabs.value,
                                isExpanded: true,
                                items: controller.getDropdownMenuItems(),
                                onChanged: (value) {
                                  controller.selectedCollabs.value =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                    IconButton(
                        onPressed: () {
                          controller.showDialogForAddCollaborator(w);
                        },
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Colors.green,
                          size: 40,
                        ))
                  ],
                ),*/
                u.vFill(h * .02),
                if (controller.selectedCollabBool
                    .any((element) => element == true))
                  getHeading("This task also visible for"),
                for (String element in controller.selectedCollabIds)
                  Column(
                    children: [u.TextWithDmSans(text: element), u.vFill(20)],
                  ),
                u.vFill(h * .02),
                getHeading("Priority"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const u.TextWithDmSans(
                      text: "Show it on the top of Todo list",
                      fontSize: 17,
                      color: Colors.black45,
                    ),
                    Transform.scale(
                        scale: 2.0,
                        child: Obx(
                          () => Checkbox(
                              activeColor: violet,
                              side: const BorderSide(
                                  color: Colors.black, width: 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: controller.goingToMakePriority.value,
                              onChanged: (bool? val) {
                                controller.goingToMakePriority.value = val!;
                              }),
                        ))
                  ],
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

class TapCalendarWidet extends StatelessWidget {
  const TapCalendarWidet({
    super.key,
    required this.controller,
    required this.h,
    required this.w,
  });

  final AddItemController controller;

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        controller.selectedDate.value = await showDatePicker(
                context: context,
                initialDate: controller.selectedDate.value,
                firstDate: DateTime(2023, 01, 01),
                lastDate: DateTime(2050, 01, 01)) ??
            controller.selectedDate.value;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          // height: h * .08,
          // width: w * .9,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(7)),
          child: Center(
              child: u.TextWithDmSans(
                  text: u.getFullDate(controller.selectedDate.value),
                  fontSize: 17,
                  weight: FontWeight.w500)),
        ),
      ),
    );
  }
}

class TapTimeWidget extends GetView<AddItemController> {
  const TapTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TimeWidget(
          w: w,
          controller: controller,
          textController: controller.sTimeStr,
          hint: "Start Time",
          callbck: () async {
            controller.startTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (controller.startTime != null) {
              controller.sTimeStr.text = u.getTimeWithAmPmFormat(DateTime(0, 0,
                  0, controller.startTime!.hour, controller.startTime!.minute));
            }
          },
        ),
        TimeWidget(
            w: w,
            controller: controller,
            textController: controller.eTimeStr,
            callbck: () async {
              if (controller.startTime != null) {
                controller.endTime = await showTimePicker(
                    builder: (context, child) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: false),
                          child: Theme(
                              data: ThemeData(
                                  textTheme: TextTheme(
                                      labelLarge: TextStyle(fontSize: 15))),
                              child: child!));
                    },
                    initialEntryMode: TimePickerEntryMode.input,
                    context: context,
                    initialTime: TimeOfDay(
                        hour: controller.startTime!.hour,
                        minute: controller.startTime!.minute + 30));
                if (controller.endTime != null) {
                  controller.eTimeStr.text = u.getTimeWithAmPmFormat(DateTime(
                      0,
                      0,
                      0,
                      controller.endTime!.hour,
                      controller.endTime!.minute));
                }
              } else {
                u.showWarning("", "Please choose start time");
              }
            },
            hint: "End Time")
      ],
    );
    /* InkWell(
      onTap: () async {
        controller.startTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        if (controller.startTime != null) {
          controller.sTimeStr.text = u.getTimeWithAmPmFormat(DateTime(0, 0, 0,
              controller.startTime!.hour, controller.startTime!.minute));
        }
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(7)),
          child: Center(
              child: u.TextWithDmSans(
                  text: controller.sTimeStr.text.isNotEmpty &&
                          controller.startTime != null
                      ? u.getTimeWithAmPmFormat(DateTime(
                          0,
                          0,
                          0,
                          controller.startTime!.hour,
                          controller.startTime!.minute))
                      : "Choose your task time",
                  fontSize: 17,
                  weight: FontWeight.w500)),
        ),
      ),
    );*/
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.w,
    required this.controller,
    required this.textController,
    required this.callbck,
    required this.hint,
  });

  final double w;
  final AddItemController controller;
  final TextEditingController textController;
  final VoidCallback callbck;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w * .4,
      child: TextFormField(
        controller: textController,
        onTap: callbck,
        readOnly: true,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.access_time_rounded,
              color: violet,
            ),
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: violet)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: violet))),
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
