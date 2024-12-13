import 'package:flutter/material.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/constant.dart' as c;

class RefreshButton extends StatelessWidget {
  const RefreshButton(
      {super.key, required this.callBack, this.iconOnly = false});
  final VoidCallback callBack;
  final bool iconOnly;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      image: "assets/icons/refresh.png",
      nameOfTheButton: "Refresh",
      iconOnly: iconOnly,
      callBack: callBack,
    );
  }
}

class AddUserButton extends StatelessWidget {
  const AddUserButton(
      {super.key, required this.callBack, this.iconOnly = false});
  final VoidCallback callBack;
  final bool iconOnly;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      image: "assets/icons/add_user.png",
      nameOfTheButton: "Add user",
      iconOnly: iconOnly,
      callBack: callBack,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.image,
    required this.nameOfTheButton,
    this.iconOnly = false,
    this.iconColor,
    this.bgColor,
    this.textColor,
    required this.callBack,
  });
  final String image;
  final String nameOfTheButton;
  final bool iconOnly;
  final Color? iconColor;
  final VoidCallback callBack;
  final Color? bgColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: bgColor ?? c.appColor,
            // ?? c.navigationContainerBg,
            borderRadius: BorderRadius.circular(5)),
        child: iconOnly
            ? Image.asset(
                image,
                color: iconColor ?? Colors.white,
                width: 25,
                height: 25,
              )
            : Row(
                children: [
                  Image.asset(
                    image,
                    color: iconColor ?? Colors.white,
                    //  c.appColor,
                    width: 25,
                    height: 25,
                  ),
                  u.hFill(10),
                  u.InterText(
                      text: nameOfTheButton, color: textColor ?? Colors.white
                      // ?? c.crudButtonTextColor,
                      )
                ],
              ),
      ),
    );
  }
}

class SimpleGreenBgElevatedBtn extends StatelessWidget {
  const SimpleGreenBgElevatedBtn(
      {super.key,
      required this.callback,
      required this.text,
      this.bg = const Color(0xff06AC5F)
      //  const Color(0xff72B93A),
      });
  final VoidCallback callback;
  final String text;
  final Color bg;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
              backgroundColor: bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
          onPressed: callback,
          child: u.PoppinsText(
            text: text,
            weight: FontWeight.w600,
            color: Colors.white,
          )),
    );
  }
}
