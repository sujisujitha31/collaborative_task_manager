import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Focus(
        focusNode: controller.focus.value,
        child: TextFormField(
          onSaved: (value) {
            controller.focus.value.unfocus();
          },
          onEditingComplete: () {
            // print("sjfbjds");
          },
          controller: controller.descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.grey.shade200,
              fillColor: Colors.blue.withOpacity(0.1),
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.titleController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}
