import 'package:flutter/material.dart';
import 'package:todo_app/components/body_container.dart';
import '../pages/menu/navigation_menu.dart';

class DesktopBaseScreen extends StatelessWidget {
  const DesktopBaseScreen({
    super.key,
  });

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF5FEFA),
        body: Row(
          children: [
            SizedBox(width: w * .17, height: h, child: buildDrawer(context)),
            SizedBox(
                height: h,
                width: w * .83,
                child:
                    BodyContainer(width: w, child: buildBodyContent(context)))
          ],
        ));
  }

// this is drawer
  buildDrawer(BuildContext context) {
    return const NavigationMenu();
  }

// this is content area
  buildBodyContent(BuildContext context) {
    return const SizedBox();
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: const TextSpan(
                  text: "© Copyright@2023 ",
                  children: [
                    TextSpan(
                        text: "Prac360 Technologies Private Limited. ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white)),
                    TextSpan(
                        text: "All Rights Reserved",
                        style: TextStyle(color: Colors.white))
                  ],
                  style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
