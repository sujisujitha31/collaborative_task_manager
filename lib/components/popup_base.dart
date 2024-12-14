import 'package:flutter/material.dart';
import 'package:get/get.dart';

getPopupBase(double w, List<Widget> child) {
  Get.dialog(
      barrierDismissible: true,
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Material(
            type: MaterialType.transparency,
            child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    width: w * .9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisSize: MainAxisSize.min, children: child))))
      ])));
}
