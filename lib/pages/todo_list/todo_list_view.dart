import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart';
import 'components/floating_button.dart';
import 'components/todo_card.dart';
import 'package:todo_app/utils.dart' as u;

class TodoListView extends GetView<TodoListController> {
  TodoListView({super.key});
  final DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          NavigationCalendar(w: w, h: h, today: today),
          LoadingWidgetOrListWidgetOfTodos(h: h * .8, today: today, w: w)
        ],
      ),
      floatingActionButton: FloatingWidget(h: h, w: w),
    );
  }
}

class NavigationCalendar extends GetView<TodoListController> {
  const NavigationCalendar({
    super.key,
    required this.w,
    required this.h,
    required this.today,
  });

  final double w;
  final double h;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListController>(builder: (cont) {
      return Container(
        width: w,
        height: h * .2,
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200))),
        child: TableCalendar(
          calendarFormat: CalendarFormat.week,
          focusedDay: controller.selectedDate.value,
          firstDay: DateTime(2024, 03, 04),
          lastDay: DateTime.now().add(
            const Duration(days: 100),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(day, controller.selectedDate.value);
          },
          onDaySelected: (selectedDay, focusedDay) {
            controller.selectDate(selectedDay);
          },
          daysOfWeekStyle: const DaysOfWeekStyle(
            decoration: BoxDecoration(),
          ),
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.dmSans(
                  color: violet, fontWeight: FontWeight.w600)),
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return calenderDaysBox(day);
            },
            selectedBuilder: (context, day, focusedDay) => calenderDaysBox(day,
                dayColor: violet,
                color: Colors.blue.withOpacity(0.2),
                weight: FontWeight.w600),
            todayBuilder: (context, day, focusedDay) => calenderDaysBox(
              day,
              dayColor: violet,
              weight: FontWeight.w600,
              border: Border.all(color: violet),
            ),
            outsideBuilder: (context, day, focusedDay) => const SizedBox(),
            disabledBuilder: (context, day, focusedDay) =>
                calenderDaysBox(day, dayColor: Colors.grey),
          ),
        ),
      );
    });
  }
}

calenderDaysBox(DateTime day,
    {LinearGradient? gradient,
    Color dayColor = Colors.black,
    FontWeight weight = FontWeight.w400,
    BoxBorder? border,
    Color? color}) {
  return Container(
    decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        gradient: gradient,
        border: border),
    height: 45,
    width: 45,
    child: Center(
        child: u.TextWithDmSans(
      text: day.day.toString(),
      color: dayColor,
      weight: weight,
    )),
  );
}

class SideButton extends StatelessWidget {
  const SideButton({
    super.key,
    required this.h,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  final double h;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 2),
      width: double.infinity,
      height: h * .2,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: TextWithDmSans(
            text: text,
            color: textColor,
            weight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

bgWhiteContainer(Widget child) {
  return Container(
    color: Colors.white,
    child: child,
  );
}
