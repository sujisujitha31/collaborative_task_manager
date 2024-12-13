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
import 'package:todo_app/pages/add_item/widgets/title_and_description_fields.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;
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
          children: [
            MandatoryTextWithchildWidget(
                width: w * .4,
                text: "Title",
                child: TextFormField(
                  decoration: getFormFieldDecoration("Enter title"),
                )),
            Spacer(),
            MandatoryTextWithchildWidget(
                width: w * .4,
                text: "description",
                child: TextFormField(
                  decoration: getFormFieldDecoration("Enter title"),
                ))
          ],
        ),
        u.vFill(20),
        Row(
          children: [
            MandatoryTextWithchildWidget(
                width: w * .4,
                text: "Collab with",
                child: CollaborationWidget(w: w * .4, controller: controller)
                //  TextFormField(
                //   decoration: getFormFieldDecoration("Enter title"),
                // )
                ),
            Spacer(),
            MandatoryTextWithchildWidget(
                width: w * .4,
                text: "description",
                child: TextFormField(
                  decoration: getFormFieldDecoration("Enter title"),
                ))
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
                  decoration: getFormFieldDecoration("Choose collaborators")
                  // InputDecoration(
                  //     hintStyle: GoogleFonts.dmSans(fontSize: 12),
                  //     hintText: "Choose collaborators",
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: violet)),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: violet))),
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

class FillUpWidget extends StatelessWidget {
  const FillUpWidget({
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
    return GetBuilder<AddItemController>(builder: (cont) {
      return Container(
        height: h * .95,
        margin: EdgeInsets.symmetric(vertical: h * .02),
        padding: EdgeInsets.symmetric(horizontal: w * .0250),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)
            //  BorderRadius.only(
            //     topLeft: Radius.circular(40), bottomLeft: Radius.circular(40))
            ),
        width: w,
        // height: h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(
              //   height: 70,
              //   child: Row(
              //     children: [
              //       u.hFill(w * .02),
              //       u.TextWithDmSans(
              //         text: "Create New Task",
              //         fontSize: 18,
              //         weight: FontWeight.w500,
              //         color: c.purpleTheme,
              //       ),
              //     ],
              //   ),
              // ),
              BodyTitle(title: "Add task"),
              u.vFill(20),
              getSizedBox(w * .95, "Title", TitleField(controller: controller)),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Description",
                DescriptionField(
                  controller: controller,
                ),
              ),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Collab-with",
                CollaborationWidget(
                  w: w * .95,
                  controller: controller,
                ),
              ),
              u.vFill(10),
              if (controller.selectedCollabNames.isNotEmpty)
                const u.PoppinsText(
                  text: "The task is also visible for:",
                ),
              if (controller.selectedCollabNames.isNotEmpty) u.vFill(10),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  for (int i = 0;
                      i < controller.selectedCollabNames.length;
                      i++)
                    SizedBox(
                      width: w * .3,
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 20,
                              child: u.PoppinsText(
                                text: controller.selectedCollabNames[i][0]
                                    .toUpperCase(),
                                weight: FontWeight.w500,
                              )),
                          u.hFill(10),
                          u.PoppinsText(
                            text: controller.selectedCollabNames[i],
                            maxLine: 3,
                          ),
                          u.hFill(10),
                        ],
                      ),
                    )
                ],
              ),
              if (controller.selectedCollabNames.isNotEmpty) u.vFill(10),
              getSizedBox(
                w * .95,
                "Date",
                TapCalendar(
                  controller: controller,
                  h: h,
                  w: w,
                ),
              ),
              u.vFill(10),
              getSizedBox(
                w * .95,
                "Priority",
                PriorityRow(
                  controller: controller,
                ),
              ),
              u.vFill(20),
              SizedBox(
                width: w * .95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            backgroundColor: c.purpleTheme),
                        onPressed: () {
                          controller.createTask();
                        },
                        child: const u.PoppinsText(
                          text: "Create",
                          color: Colors.white,
                          fontSize: 16,
                          weight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              u.vFill(15)
            ],
          ),
        ),
      );
    });
  }
}

getSizedBox(double w, String title, Widget child) {
  return SizedBox(
    width: w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [getHeading(title), child],
    ),
  );
}

getAddItemSingleRow(Widget w1, Widget w2) {
  return Row(
    children: [
      const Spacer(),
      w1,
      const Spacer(
        flex: 2,
      ),
      w2,
      const Spacer()
    ],
  );
}
