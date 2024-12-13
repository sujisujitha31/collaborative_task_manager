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
            color: bgColor ?? c.navigationContainerBg,
            borderRadius: BorderRadius.circular(5)),
        child: iconOnly
            ? Image.asset(
                image,
                color: iconColor,
                width: 25,
                height: 25,
              )
            : Row(
                children: [
                  Image.asset(
                    image,
                    color: iconColor ?? c.appColor,
                    width: 25,
                    height: 25,
                  ),
                  u.hFill(10),
                  u.InterText(
                    text: nameOfTheButton,
                    color: textColor ?? c.crudButtonTextColor,
                  )
                ],
              ),
      ),
    );
  }
}
