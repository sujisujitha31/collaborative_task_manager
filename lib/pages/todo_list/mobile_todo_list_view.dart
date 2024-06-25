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

class MobileTodoListView extends GetView<TodoListController> {
  MobileTodoListView({super.key});
  final DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          NavigationCalendar(w: w, today: today),
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
    // required this.h,
    required this.today,
  });

  final double w;
  // final double h;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListController>(builder: (cont) {
      return Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: w,
        decoration: const BoxDecoration(
            // color: Colors.blue.withOpacity(0.1),
            // borderRadius: BorderRadius.circular(10),
            // boxShadow: u.getBoxShadow()
            ),
        child: TableCalendar(
          // daysOfWeekVisible: false,
          calendarFormat: CalendarFormat.month,
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
          // headerVisible: false,
          startingDayOfWeek: StartingDayOfWeek.monday,

          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              return u.getSingleLetterWeekDay(date);
            },
            decoration: const BoxDecoration(),
          ),
          headerStyle: HeaderStyle(
              leftChevronIcon: getChevIcon(Icons.chevron_left_rounded),
              rightChevronIcon: getChevIcon(Icons.chevron_right_rounded),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.dmSans(
                  color: const Color(0xff4e4dac), fontWeight: FontWeight.w600)),
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return calenderDaysBox(day);
            },
            selectedBuilder: (context, day, focusedDay) => calenderDaysBox(day,
                dayColor: Colors.white,
                color: const Color(0xff4e4dac),
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

  Container getChevIcon(IconData data) {
    return Container(
      decoration:
          const BoxDecoration(color: Color(0xffb4b4da), shape: BoxShape.circle),
      padding: const EdgeInsetsDirectional.all(5),
      child: Icon(
        data,
        color: Colors.white,
      ),
    );
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
    height: 35,
    width: 35,
    child: Center(
        child: u.TextWithDmSans(
      text: day.day.toString(),
      color: dayColor,
      weight: weight,
      fontSize: 12,
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
