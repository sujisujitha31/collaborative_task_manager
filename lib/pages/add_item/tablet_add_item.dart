import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/add_item/add_item_controller.dart';

import 'desktop_add_item.dart';

class TabletAddITemView extends GetView<AddItemController> {
  const TabletAddITemView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return AddItemBodyWidget(
      w: w,
      h: h,
      controller: controller,
    );
  }
}
