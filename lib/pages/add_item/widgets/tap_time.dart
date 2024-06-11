import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
// import 'package:todo_app/globals.dart' as g;

// import 'widgets/title_and_description_fields.dart';

class TapTime extends GetView<AddItemController> {
  const TapTime(this.w, {super.key});
  final double w;
  @override
  Widget build(BuildContext context) {
    // h = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: w * .45,
          child: TimeWidget(
            controller: controller,
            textController: controller.sTimeStr,
            hint: "Start Time",
            callbck: () async {
              controller.startTime = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (controller.startTime != null) {
                controller.sTimeStr.text = u.getTimeWithAmPmFormat(DateTime(
                    0,
                    0,
                    0,
                    controller.startTime!.hour,
                    controller.startTime!.minute));
              }
            },
          ),
        ),
        SizedBox(
          width: w * .45,
          child: TimeWidget(
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
                                    textTheme: const TextTheme(
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
              hint: "End Time"),
        )
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    // required this.w,
    required this.controller,
    required this.textController,
    required this.callbck,
    required this.hint,
  });

  // final double w;
  final AddItemController controller;
  final TextEditingController textController;
  final VoidCallback callbck;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onTap: callbck,
      readOnly: true,
      decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.access_time_rounded,
            color: violet,
          ),
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(fontSize: 12),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: violet)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: violet))),
    );
  }
}
// 