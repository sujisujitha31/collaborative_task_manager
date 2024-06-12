import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/menu/menu_controller.dart';
import 'package:todo_app/responsive.dart';

import 'base_screen/desktop_base_screen.dart';
import 'base_screen/mobile_base_screen.dart';
import 'base_screen/tablet_base_screen.dart';

class ResponsiveBaseScreen extends StatelessWidget {
  const ResponsiveBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobileScaffold: Mobile(),
        tabletScaffold: const Tablet(),
        desktopScaffold: Desktop());
  }
}

class Desktop extends DesktopBaseScreen {
  Desktop({Key? key})
      : super(
          key: key,
        );
  final controller = Get.find<SideMenuController>();
  @override
  buildBodyContent(BuildContext context) {
    print("inside desktop");
    return Obx(() => controller.desktopPages[controller.selectedPage.value]);
  }

  @override
  buildDrawer(BuildContext context) {
    // TODO: implement buildDrawer
    return super.buildDrawer(context);
  }
}

class Tablet extends TabletBaseScreen {
  const Tablet({Key? key})
      : super(
          key: key,
        );

  @override
  buildBodyContent(BuildContext context) {
    final controller = Get.find<SideMenuController>();
    return Obx(() => controller.tabletPages[controller.selectedPage.value]);
  }
}

class Mobile extends MobileBaseScreen {
  Mobile({Key? key})
      : super(
          key: key,
        );
  final controller = Get.find<SideMenuController>();
  @override
  buildBodyContent(BuildContext context) {
    return Obx(() => controller.mobilePages[controller.selectedPage.value]);
  }
}
