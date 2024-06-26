import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/base_screen/base_screen_controller.dart';
import 'package:todo_app/utils.dart' as u;

import '../pages/menu/menu_view.dart';

class TabletBaseScreen extends StatelessWidget {
  const TabletBaseScreen({
    super.key,
  });
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseScreenController>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: controller.scaffoldState,
      drawer: SizedBox(width: width * .35, child: SideMenu()),
      body: Column(
        children: [
          Container(
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: u.getBoxShadow()),
            height: 70,
            // height * .1,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      controller.scaffoldState.currentState?.openDrawer();
                    },
                    child: Icon(Icons.menu))
              ],
            ),
          ),
          // buildDrawer(context),
          buildBodyContent(context)
        ],
      ),
    );
  }

  buildDrawer(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * .15,
    );
  }

// this is content area
  buildBodyContent(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * .85,
    );
  }

  buildBodyScreen(BuildContext context) {}
}
