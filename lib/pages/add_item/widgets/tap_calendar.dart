import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;

// import 'widgets/title_and_description_fields.dart';

class TapCalendar extends StatelessWidget {
  const TapCalendar({
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
                firstDate: DateTime.now(),
                lastDate: DateTime(2050, 01, 01)) ??
            controller.selectedDate.value;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(7)),
          child: Center(
              child: u.PoppinsText(
                  text: u.getFullDate(controller.selectedDate.value),
                  fontSize: 12,
                  weight: FontWeight.w500)),
        ),
      ),
    );
  }
}
