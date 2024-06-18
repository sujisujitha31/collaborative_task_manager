import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.controller,
  });

  final AddItemController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.roboto(fontSize: 12),
      controller: controller.descriptionController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none)),
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
      style: GoogleFonts.dmSans(fontSize: 12),
      controller: controller.titleController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}
