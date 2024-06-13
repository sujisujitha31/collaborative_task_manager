import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/firebase/firebase_database.dart';
import 'package:todo_app/pages/login/desktop_login_view.dart';
import 'package:todo_app/pages/login/mobile_login_view.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/responsive_base_screen.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;
import 'package:todo_app/constant.dart' as c;

import '../../responsive.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordVisibilityOff = true.obs;
  changePasswordVisibility() {
    passwordVisibilityOff.value = !passwordVisibilityOff.value;
    update();
  }

  validateEmailAndPassword() {
    if (emailController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter email id");
      return true;
    } else if (passwordController.text.isEmpty) {
      u.showWarning("Warning", "Please Enter password");
      return true;
    } else if (passwordController.text.length < 6) {
      u.showWarning("Warning", "Please give password Atleast 6 characters");
      return true;
    } else {
      return false;
    }
  }

  onLogin() {
    if (validateEmailAndPassword()) {
      return;
    }

    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((user) {});
    } on FirebaseAuthException catch (e) {
      invalidLoginPopup();
      print(e);
    } catch (e) {
      invalidLoginPopup();
      print(e);
    }
  }

  Future<dynamic> invalidLoginPopup() {
    return Get.defaultDialog(
        title: "oops!",
        titleStyle: GoogleFonts.dmSans(fontSize: 12),
        content: const u.TextWithDmSans(
            text: "Provided email/password is invalid.could you check it out."),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: c.violet),
              onPressed: () {
                Get.back();
              },
              child: const u.TextWithDmSans(
                text: "Okay",
                color: Colors.white,
              ))
        ]);
  }

  onLogout() {
    clearCredentials();
    FirebaseAuth.instance.signOut();
  }

  createNewUser() async {
    validateEmailAndPassword();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((user) {
        // if (user == null) {
        //   Get.offAll(() => TodoListView());
        // } else {}
        print(user);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  checkUserLoggedInOrNot() {
    validateEmailAndPassword();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Get.offAll(() => const Responsive(
            desktopScaffold: DesktopLoginView(),
            tabletScaffold: SizedBox(),
            mobileScaffold: LoginView()));
      } else {
        g.userMail = user.email!;
        getCollabarators();
        final todoController = Get.find<TodoListController>();
        todoController.searchByToday();
        todoController.getTodos();
        Get.offAll(() => const ResponsiveBaseScreen());
      }
    });
  }

  clearCredentials() {
    emailController.text = "";
    passwordController.text = "";
  }

  getCollabarators() {
    FirebaseDatabase().getAllCollaborators(
      onSuccess: (data) {
        g.collabUsers = data.get(c.Constants.kListOfCollab);
      },
      onError: (err) {
        // print("get error ${err}");
      },
    );
  }
}
