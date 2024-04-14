import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/pages/login/login_controller.dart';
import 'package:todo_app/utils.dart' as u;

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * .45,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    violetLight,
                    violet,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
                Container(
                  color: Colors.white,
                  width: width,
                  height: height * .55,
                  child: SignUpWidgets(width: width, height: height),
                )
              ],
            ),
          ),
          Positioned(
            top: height * .1,
            child: Container(
              width: width * .86,
              margin: EdgeInsets.symmetric(horizontal: width * .07),
              padding:
                  EdgeInsets.symmetric(horizontal: width * .03, vertical: 10),
              height: height * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: u.getBoxShadow()),
              child: LoginBody(
                height: height,
                controller: controller,
                width: width,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.height,
    required this.controller,
    required this.width,
  });

  final double height;
  final LoginController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const u.TextWithDmSans(
          text: "Login",
          fontSize: 25,
          weight: FontWeight.w700,
        ),
        u.vFill(height * .03),
        TextFormField(
          style: GoogleFonts.dmSans(),
          controller: controller.emailController,
          decoration: InputDecoration(
              // focusColor: violet,
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: violet)),
              hintStyle: GoogleFonts.dmSans(fontSize: 12),
              hintText: "Enter your mail id",
              prefixIcon: Icon(
                Icons.email,
                color: violet,
              )),
        ),
        u.vFill(height * .03),
        TextFormField(
          controller: controller.passwordController,
          decoration: InputDecoration(
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: violet)),
              hintStyle: GoogleFonts.dmSans(fontSize: 12),
              hintText: "Enter your password",
              prefixIcon: Icon(
                Icons.lock,
                color: violet,
              ),
              suffixIcon: const Icon(
                Icons.visibility,
              )),
        ),
        u.vFill(height * .05),
        SizedBox(
          width: width * .6,
          child: Center(
            child: InkWell(
              onTap: () => controller.onLogin(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: [
                      violetLight,
                      violet,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                padding: EdgeInsets.symmetric(vertical: height * .02),
                child: const Center(
                  child: u.TextWithDmSans(
                    text: "Login",
                    color: Colors.white,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SignUpWidgets extends StatelessWidget {
  const SignUpWidgets({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const u.TextWithDmSans(
          text: "Continue with",
        ),
        u.vFill(10),
        OAuthRow(width: width),
        u.vFill(height * .07),
        const u.TextWithDmSans(
          text: "Don't have an account?",
        ),
        u.vFill(10),
        InkWell(
          child: u.TextWithDmSans(
            text: "Create account",
            weight: FontWeight.w600,
            color: violet,
          ),
        ),
        u.vFill(height * .05)
      ],
    );
  }
}

class OAuthRow extends StatelessWidget {
  const OAuthRow({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: width * .4,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 7)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/google.png",
                  height: 30,
                  width: 30,
                ),
                u.hFill(10),
                const u.TextWithDmSans(
                  text: "google",
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        u.hFill(10),
        SizedBox(
          width: width * .4,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 7)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/github.png",
                  height: 30,
                  width: 30,
                ),
                u.hFill(10),
                const u.TextWithDmSans(
                  text: "github",
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField(
      {super.key,
      required this.hint,
      required this.data,
      this.isPasswordField});
  final String hint;
  final IconData data;
  final Icon? isPasswordField;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            data,
            color: violet,
          ),
          suffixIcon: isPasswordField,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: violet),
          hintText: hint,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: violet)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: violet))),
    );
  }
}
