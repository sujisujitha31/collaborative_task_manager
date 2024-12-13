import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/menu/navigation_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/constant.dart' as c;

class NavigationMenu extends GetView<SideMenuController> {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuController>(builder: (cont) {
      return Container(
          // margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: c.navigationContainerBg,
              border: Border(
                  right: BorderSide(
                      color: c.appColor.withOpacity(0.5), width: 0.2))),
          height: MediaQuery.of(context).size.height * .9,
          width: double.infinity,
          child: Column(
            children: [
              // u.vFill(20),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.menuTitles.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      controller.goToPage(
                          controller.menuTitles.entries.toList()[index].key,
                          context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: controller.menuTitles.entries
                                      .toList()[index]
                                      .key ==
                                  controller.selectedPage.value
                              ? c.selectedNavigation
                              : null),
                      child: Row(
                        children: [
                          Image.asset(
                            controller.icons.entries.toList()[index].value,
                            color: c.appColor,
                            width: 25,
                            height: 25,
                          ),
                          u.hFill(10),
                          u.PoppinsText(
                            text: controller.menuTitles.entries
                                .toList()[index]
                                .value,
                            fontSize: 15,
                            color: controller.menuTitles.entries
                                        .toList()[index]
                                        .key ==
                                    controller.selectedPage.value
                                ? c.appColor
                                : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ));
    });
  }
}
