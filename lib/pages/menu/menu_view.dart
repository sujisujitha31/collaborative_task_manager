import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/menu/menu_controller.dart';
import 'package:todo_app/utils.dart' as u;

class SideMenu extends GetView<SideMenuController> {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuController>(builder: (cont) {
      return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              color: Color(0xff4e4dac),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(40))),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              u.vFill(20),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 30,
                  );
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
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: controller.menuTitles.entries
                                      .toList()[index]
                                      .key ==
                                  controller.selectedPage.value
                              ? BorderRadius.circular(10)
                              : null,
                          color: controller.menuTitles.entries
                                      .toList()[index]
                                      .key ==
                                  controller.selectedPage.value
                              ? Colors.white
                              : null),
                      child: Row(
                        children: [
                          // u.hFill(5),
                          Icon(
                            controller.icons.entries.toList()[index].value,
                            color: controller.menuTitles.entries
                                        .toList()[index]
                                        .key ==
                                    controller.selectedPage.value
                                ? const Color(0xff4e4dac)
                                : Colors.white,
                            // size: 35,
                          ),
                          // u.hFill(5),
                          const Spacer(),
                          u.TextWithDmSans(
                            text: controller.menuTitles.entries
                                .toList()[index]
                                .value,
                            color: controller.menuTitles.entries
                                        .toList()[index]
                                        .key ==
                                    controller.selectedPage.value
                                ? const Color(0xff4e4dac)
                                : Colors.white,
                            //  index == controller.selectedPage.value
                            //     ? Colors.white
                            //     : violet,
                          ),
                          // u.hFill(5),
                          const Spacer(
                            flex: 2,
                          )
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
