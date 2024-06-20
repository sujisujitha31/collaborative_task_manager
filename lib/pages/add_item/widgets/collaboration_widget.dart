import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

import '../add_item_view.dart';

// import 'widgets/title_and_description_fields.dart';

class ShareTaskListWidget extends StatelessWidget {
  const ShareTaskListWidget({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddItemController>(
        builder: (cont) => controller.selectedCollabBool
                .any((element) => element == true)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeading("This task also visible for"),
                  for (String element in controller.selectedCollabIds)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [u.TextWithDmSans(text: element), u.vFill(20)],
                    ),
                ],
              )
            : const SizedBox());
  }
}

class CollaborationWidget extends StatelessWidget {
  const CollaborationWidget({
    super.key,
    required this.w,
    required this.controller,
  });

  final double w;
  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: w * .7,
          child: g.collabUsers.isEmpty
              ? const u.TextWithDmSans(
                  text: "There is no collaboraters added yet")
              : TextFormField(
                  readOnly: true,
                  onTap: () {
                    controller.showAddCollabaratorToTask();
                  },
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.dmSans(fontSize: 12),
                      hintText: "Choose collaborators",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: violet)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: violet))),
                ),
        ),
        SizedBox(
            width: w * .2,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    controller.showDialogForAddCollaborator(w);
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.green,
                    size: 40,
                  )),
            )),
      ],
    );
  }
}
