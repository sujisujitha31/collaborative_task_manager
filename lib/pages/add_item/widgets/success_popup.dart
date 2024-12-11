import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils.dart' as u;

showSuccessPopup() {
  double w = MediaQuery.of(Get.overlayContext!).size.width;
  Get.dialog(Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(5)),
          width: w * .7,
          child: Column(
            children: [
              const u.PoppinsText(
                text: "Added",
                weight: FontWeight.w500,
                fontSize: 22,
              ),
              u.vFill(30),
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 70,
              ),
              u.vFill(20),
              const u.PoppinsText(
                text: "Congratulations!",
              ),
              const u.PoppinsText(
                text: "Your task has been successfully added.",
              ),
              u.vFill(20),
              SizedBox(
                width: w * .5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff111154)),
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    child: const u.PoppinsText(
                      text: "Okay",
                      color: Colors.white,
                      weight: FontWeight.w500,
                      fontSize: 15,
                    )),
              )
            ],
          ),
        ),
      ),
    ],
  ));
}
