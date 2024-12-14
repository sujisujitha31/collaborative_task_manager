import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/components/formfield_decoration.dart';
import 'package:todo_app/components/information_popup.dart';
import 'package:todo_app/components/popup_base.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/constant.dart' as c;

showAddCollaboratorPopup(Function() callback) {
  double w = MediaQuery.of(Get.overlayContext!).size.width;
  double deviceWidth =
      u.getResponsiveSize(Get.overlayContext!, w * .9, w * .35, w * .25);

  final addTaskCont = Get.find<AddItemController>();
  getPopupBase(deviceWidth, [
    getConfirmationPopupIcon(
      const Color(0xffF7FFF0),
      const Color(0xffEAFFDA),
      "assets/icons/add_user.png",
    ),
    u.vFill(20),
    const u.InterText(
        text: "Add collaborator", weight: FontWeight.w600, fontSize: 20),
    u.vFill(20),
    TextFormField(
      style: GoogleFonts.inter(),
      controller: addTaskCont.collbName,
      decoration: getFormFieldDecoration("Name"),
    ),
    u.vFill(20),
    TextFormField(
      style: GoogleFonts.inter(),
      controller: addTaskCont.collabMail,
      decoration: getFormFieldDecoration("Email"),
    ),
    u.vFill(20),
    Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(
          flex: 2,
        ),
        SizedBox(
          width: deviceWidth * .35,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xffD0D5DD)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Get.back();
              },
              child: const u.InterText(
                  text: "Cancel",
                  color: Color(0xff344054),
                  weight: FontWeight.w600)),
        ),
        u.hFill(20),
        SizedBox(
          width: deviceWidth * .35,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: c.appColor),
              onPressed: () {
                callback();
              },
              child: const u.InterText(
                  text: "Add", color: Colors.white, weight: FontWeight.w600)),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    ),
    u.vFill(20)
  ]);
}
