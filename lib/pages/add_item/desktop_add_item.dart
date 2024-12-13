import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/components/body_title.dart';
import 'package:todo_app/components/mandatory_text.dart';
import 'package:todo_app/constant.dart' as c;
import 'package:todo_app/pages/add_item/add_item_controller.dart';
import 'package:todo_app/pages/add_item/widgets/priority_row.dart';
import 'package:todo_app/pages/add_item/widgets/tap_calendar.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;
import '../../components/crud_components.dart';
import 'add_item_view.dart';

class DesktopAddTaskView extends GetView<AddItemController> {
  const DesktopAddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * .8;
    double h = MediaQuery.of(context).size.height;
    return AddItemBodyWidget(w: w, controller: controller, h: h);
  }
}

class AddItemBodyWidget extends StatelessWidget {
  const AddItemBodyWidget({
    super.key,
    required this.w,
    required this.controller,
    required this.h,
  });

  final double w;
  final AddItemController controller;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyTitle(title: "Add task"),
        u.vFill(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                MandatoryTextWithchildWidget(
                    width: w * .4,
                    text: "Task title",
                    child: TextFormField(
                      controller: controller.titleController,
                      decoration: getFormFieldDecoration("Enter title"),
                    )),
                u.vFill(20),
                MandatoryTextWithchildWidget(
                    width: w * .4,
                    text: "Collab with",
                    isMandatory: false,
                    child:
                        CollaborationWidget(w: w * .4, controller: controller)
                    //  TextFormField(
                    //   decoration: getFormFieldDecoration("Enter title"),
                    // )
                    ),
              ],
            ),
            Spacer(),
            MandatoryTextWithchildWidget(
                // isMandatory: false,
                width: w * .5,
                text: "Task description",
                child: TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 5,
                  decoration: getFormFieldDecoration("Description of the task"),
                ))
          ],
        ),
        u.vFill(20),
        Row(
          children: [
            MandatoryTextWithchildWidget(
                width: w * .4,
                text: "Date",
                isMandatory: false,
                child: TapCalendar(
                  controller: controller,
                )),
            Spacer(),
            MandatoryTextWithchildWidget(
              width: w * .5,
              text: "Priority",
              isMandatory: false,
              child: PriorityRow(
                controller: controller,
              ),
            )
          ],
        ),
        u.vFill(20),
        Row(
          children: [
            Spacer(),
            SimpleGreenBgElevatedBtn(
                callback: () {
                  controller.validateInputs();
                },
                text: "Add new task")
          ],
        )
      ],
    );
  }
}

InputDecoration getFormFieldDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
          color: Color(
            0xff5F6061,
          ),
          fontSize: 14),
      fillColor:
          //  bgColor != null ?
          c.dropDownBgColor,
      //  : null,
      filled: true,
      //  bgColor ?? false,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: c.dropdownBorderColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.dropdownBorderColor)));
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
              ? const u.PoppinsText(text: "There is no collaboraters added yet")
              : TextFormField(
                  readOnly: true,
                  onTap: () {
                    controller.showAddCollabaratorToTask();
                  },
                  decoration: getFormFieldDecoration("Choose collaborators")),
        ),
        u.hFill(25),
        Image.asset(
          "assets/icons/add_user.png",
          color: c.appColor,
          width: 30,
          height: 30,
        )
      ],
    );
  }
}
