import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils.dart' as u;
import '../todo_list_controller.dart';

class TimeAndCalendarHeader extends GetView<TodoListController> {
  const TimeAndCalendarHeader({
    super.key,
    required this.h,
    required this.today,
  });

  final double h;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            u.TextWithDmSans(
              text: "${u.getMonthName(today)} ${today.year}",
              color: Colors.white,
              fontSize: 16,
              weight: FontWeight.w600,
            ),
            u.TextWithDmSans(
                text: "${today.day} ${u.getWeekDay(today)}",
                // color: darkGreen,
                color: Colors.white,
                fontSize: 40,
                weight: FontWeight.w900),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            controller.openTheCalendar();
          },
          child: Row(
            children: [
              const u.TextWithDmSans(
                text: "Calendar",
                fontSize: 18,
                color: Colors.white,
              ),
              u.hFill(2),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }
}
