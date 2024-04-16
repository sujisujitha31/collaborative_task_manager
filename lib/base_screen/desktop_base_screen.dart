import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/utils.dart' as u;
import '../pages/menu/menu_view.dart';

class DesktopBaseScreen extends StatelessWidget {
  const DesktopBaseScreen({
    Key? key,
  }) : super(key: key);

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xfff5f5fa),
        body: SafeArea(
          child: Row(
            children: [
              SizedBox(width: w * .17, child: buildDrawer(context)),
              SizedBox(width: w * .83, child: buildBodyContent(context))
            ],
          ),
        ));
  }

// this is drawer
  buildDrawer(BuildContext context) {
    return SideMenu();
  }

// this is content area
  buildBodyContent(BuildContext context) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width * .83,
        );
  }

  /* buildBodyScreen(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .83,
      child: SingleChildScrollView(
        child: GetBuilder(builder: (cont) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: const [],
                  ),
                ),
              ),
              Container(
                  color: Colors.grey.shade100,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: buildBodyContent(context)))
            ],
          );
        }),
      ),
    );
  }*/
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
