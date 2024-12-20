import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;

class PriorityRow extends StatelessWidget {
  const PriorityRow({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const u.InterText(
          text: "Show it on the top of Todo list",
          fontSize: 14,
          color: Colors.black45,
        ),
        u.hFill(25),
        // const Spacer(),
        Transform.scale(
            scale: 1.5,
            child: Obx(
              () => Checkbox(
                  activeColor: appColor,
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  value: controller.goingToMakePriority.value,
                  onChanged: (bool? val) {
                    controller.goingToMakePriority.value = val!;
                  }),
            )),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
