import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart' as c;

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
