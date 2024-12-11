import 'package:flutter/foundation.dart' as web;
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart' as c;

import '../components/body_container.dart';
import '../pages/menu/navigation_menu.dart';

class DesktopBaseScreen extends StatelessWidget {
  const DesktopBaseScreen({
    super.key,
  });

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: c.scaffoldBg,
        body: getDesktopBase(getBody(context)));
  }

  getBody(BuildContext context) {
    return Column(children: [
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .1,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: buildHeader()),
      Row(
        children: [buildDrawer(context), buildBodyScreen(context)],
      ),
    ]);
  }

  getDesktopBase(Widget child) {
    if (web.kIsWeb) {
      return child;
    } else {
      return SafeArea(child: child);
    }
  }

// this is drawer
  buildDrawer(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .17,
        child: const Column(
          children: [
            NavigationMenu(),
          ],
        ));
  }

// this is content area
  buildBodyContent(BuildContext context) {
    return const SizedBox();
  }

  buildBodyScreen(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return

        // Obx(
        // () =>
        SizedBox(
      height:
          //  web.kIsWeb ?

          screenSize.height * .9,
      //  : screenSize.height * .84,
      width: screenSize.width * .83,
      child: SingleChildScrollView(
          child: BodyContainer(
              width: screenSize.width * .8, child: buildBodyContent(context))
          // Get.find<LoginController>().isDashBoard.value
          //     ? BodyContainerForDashBoard(
          //         width: screenSize.width * .8,
          //         child: buildBodyContent(context))
          //     :),
          ),
    );
  }

  buildHeader() {
    return const SizedBox();
  }
}
/*
class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final login = Get.find<LoginController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        u.hFill(10),
        InkWell(
          onTap: () {
            Get.find<NavigationController>().selectedPage.value =
                c.ConstantLabels.kMainMenuDashboard;
            Get.find<LoginController>().getInitialValues();
            u.goToPage(c.ConstantLabels.kMainMenuDashboard);
          },
          child: CustomIcon(
            icon: "assets/images/neovault.png",
            height: 50,
            width: w * .15,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            final overlay = Overlay.of(context);
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            var overlayPosition = renderBox.localToGlobal(Offset.zero);
            OverlayEntry? entry;

            entry = OverlayEntry(
              builder: (context) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      entry?.remove();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    top: overlayPosition.dy + renderBox.size.height,
                    right: 10,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (login.loginInfo.value.image != null)
                                  ClipOval(
                                    child: _buildProfileImage(
                                        login.loginInfo.value.image!),
                                  ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    u.PoppinsText(
                                        text: login.loginInfo.value.fullName ??
                                            'User',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                    u.PoppinsText(
                                        text: login.loginInfo.value.email ??
                                            'email@example.com',
                                        fontSize: 12,
                                        textColor: Colors.grey),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Divider(),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                entry?.remove();
                                showChangePasswordPopup();
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.lock, size: 22),
                                  SizedBox(width: 12),
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                entry?.remove();
                                await Get.find<LoginController>().onLogout();
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.logout, size: 22),
                                  SizedBox(width: 12),
                                  u.PoppinsText(
                                    text: "Log Out",
                                    textColor: Colors.red,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            overlay.insert(entry);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (login.loginInfo.value.image != null)
                  ClipOval(
                    child: _buildProfileImage(login.loginInfo.value.image!),
                  ),
                u.hFill(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    u.PoppinsText(
                      text: login.loginInfo.value.fullName ?? "--",
                    ),
                    u.PoppinsText(
                      text: login.loginInfo.value.role?.name ?? "--",
                      textColor: const Color(0xff86929E),
                      fontSize: 10,
                    ),
                  ],
                ),
                u.hFill(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildProfileImage(String imageUrl) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: CachedNetworkImage(
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 35,
      ),
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.person),
      imageUrl: imageUrl,
    ),
  );
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: u.PoppinsText(
        text: "Copyright© 2024 Neopharma Technologies Limited",
        textColor: Color(0xff494949),
      ),
    );
  }
}*/
