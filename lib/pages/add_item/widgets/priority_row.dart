import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

class PriorityRow extends StatelessWidget {
  const PriorityRow({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const u.TextWithDmSans(
          text: "Show it on the top of Todo list",
          fontSize: 17,
          color: Colors.black45,
        ),
        Transform.scale(
            scale: 2.0,
            child: Obx(
              () => Checkbox(
                  activeColor: violet,
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  value: controller.goingToMakePriority.value,
                  onChanged: (bool? val) {
                    controller.goingToMakePriority.value = val!;
                  }),
            ))
      ],
    );
  }
}
