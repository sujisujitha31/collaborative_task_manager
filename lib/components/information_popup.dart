import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:todo/utils.dart' as u;
// import 'package:todo/constant.dart' as c;
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/constant.dart' as c;

showInformationPopup(Widget icon, String title, String info,
    String clickActionLabel, bool showCancel, Function callback,
    {String? cancelLabel, Function()? cancelCallback}) {
  double w = MediaQuery.of(Get.overlayContext!).size.width;
  return Get.dialog(
    barrierDismissible: true,
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
              type: MaterialType.transparency,
              child: Center(
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  width: w * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      u.vFill(10),
                      icon,
                      u.vFill(10),
                      u.InterText(
                          text: title, weight: FontWeight.w600, fontSize: 20),
                      u.vFill(10),
                      SizedBox(
                          width: w * .7,
                          child: u.InterText(
                              text: info,
                              // textAlign: TextAlign.center,
                              color: Color(0xff475467))),
                      u.vFill(20),
                      showCancel
                          ? Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(
                                  flex: 2,
                                ),
                                SizedBox(
                                  width: w * .35,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: Color(0xffD0D5DD)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        if (cancelCallback != null) {
                                          cancelCallback();
                                        }
                                      },
                                      child: u.InterText(
                                          text: cancelLabel ?? "Cancel",
                                          color: Color(0xff344054),
                                          weight: FontWeight.w600)),
                                ),
                                u.hFill(20),
                                SizedBox(
                                  width: w * .35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          backgroundColor: c.appColor),
                                      onPressed: () {
                                        callback();
                                      },
                                      child: u.InterText(
                                          text: clickActionLabel,
                                          color: Colors.white,
                                          weight: FontWeight.w600)),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                              ],
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: c.appColor),
                              onPressed: () {
                                callback();
                              },
                              child: u.InterText(
                                  text: clickActionLabel, color: Colors.white)),
                      u.vFill(20)
                    ],
                  ),
                ),
              )),
        ],
      ),
    ),
  );
}

getConfirmationPopupIcon(Color color1, Color color2, String image) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: color1, shape: BoxShape.circle),
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: color2, shape: BoxShape.circle),
      child: Image.asset(
        image,
        height: 30,
        width: 30,
        color: c.appColor,
      ),
    ),
  );
}
