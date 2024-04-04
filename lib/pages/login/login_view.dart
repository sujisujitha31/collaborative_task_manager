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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const u.TextWithDmSans(
                        text: "Continue with",
                      ),
                      u.vFill(10),
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: width * .4,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7)),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7)),
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
                      ),
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
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: height * .25,
            child: Container(
              width: width * .86,
              margin: EdgeInsets.symmetric(horizontal: width * .07),
              padding:
                  EdgeInsets.symmetric(horizontal: width * .03, vertical: 10),
              height: height * .4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: u.getBoxShadow()),
              child: Column(
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
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: violet)),
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
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: violet)),
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
                              gradient: LinearGradient(
                                  colors: [
                                    violetLight,
                                    violet,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)),
                          padding: const EdgeInsets.symmetric(vertical: 20),
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
              ),
            ),
          )
        ],
      ),
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
