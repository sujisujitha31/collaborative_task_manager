import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/constant.dart';

Logger log = Logger();
String getWeekDay(DateTime day) {
  return DateFormat.E().format(day);
}

String getSingleLetterWeekDay(DateTime date) {
  return DateFormat.E().format(date)[0];
}

String getMonthName(DateTime day) {
  return DateFormat("MMMM").format(day);
}

String getFullDate(DateTime day) {
  return DateFormat.yMMMMEEEEd().format(day);
}

String getTimeWithAmPmFormat(DateTime date) {
  return DateFormat.Hm().format(date).toString();
}

class TextWithDmSans extends StatelessWidget {
  const TextWithDmSans(
      {super.key,
      required this.text,
      this.color,
      this.weight,
      this.fontSize = 12,
      this.overflow = TextOverflow.ellipsis,
      this.decoration,
      this.maxLine});
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? fontSize;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          color: color,
          fontSize: fontSize,
          fontWeight: weight,
          decoration: decoration),
      overflow: overflow,
      maxLines: maxLine,
    );
  }
}

hFill(double size) {
  return SizedBox(
    width: size,
  );
}

vFill(double size) {
  return SizedBox(
    height: size,
  );
}

bool isLoading = false;
showLoading(message) {
  isLoading = true;
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    boxShadow: getBoxShadow()),
                child: CircularProgressIndicator(
                  // value: 0.5,
                  strokeWidth: 2.5,
                  color: violet,
                ),
              ),
              vFill(10),
              Text('$message...',
                  style: const TextStyle(fontSize: 20, color: Colors.white))
            ],
          ),
        ),
      ),
    ),
  );
}

closeLoading() {
  if (isLoading) {
    isLoading = false;
    Navigator.of(Get.overlayContext!).pop();
  }
}

showWarning(String title, String msg) {
  // Get.snackbar(title, msg,
  //     duration: Duration(milliseconds: 1000),
  //     titleText: Row(
  //       children: const [
  //         Icon(
  //           Icons.warning_rounded,
  //           color: Colors.blue,
  //         ),
  //       ],
  //     ),
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.blue.shade50,
  //     colorText: Colors.blue);
  showModalBottomSheet(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(Get.overlayContext!).size.width),
      context: Get.overlayContext!,
      builder: (context) {
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;
        return Container(
          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2)),
          height: h * .1,
          // width: w * 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: w * .9,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWithDmSans(
                      text: msg,
                      color: const Color(0xFF2F80EC),
                      maxLine: 3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * .1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close)),
                ),
              )
            ],
          ),
        );
      });
}

List<BoxShadow> getBoxShadow() {
  return const [
    BoxShadow(
      color: Colors.black12,
      //  Color(0x1F000000);
      offset: Offset(
        0,
        4,
      ),
      blurRadius: 10,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];
}
