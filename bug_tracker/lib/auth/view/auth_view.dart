import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/input_field.dart';
import '../../widgets/snack_bar.dart';
import '../controller/auth_controller.dart';

class AuthView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        color: Colors.deepPurple,
        child: Form(
          key: formKey,
          child: SizedBox(
            width: size.width * 0.5,
            child: Obx(
              () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Bug Tracker System",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (controller.authState.value == AuthState.signup)
                      InputField(
                        title: "Name",
                        hint: "enter your name here",
                        onchange: controller.setName,
                      ),
                    InputField(
                      title: "Email",
                      hint: "enter your email here",
                      onchange: controller.setEmail,
                    ),
                    InputField(
                        title: "Password",
                        hint: "enter your password here",
                        obscureText: true,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "you forgot to enter the password";
                          }
                          return null;
                        },
                        onchange: controller.setPassword),
                    if (controller.authState.value == AuthState.signup)
                      InputField(
                        title: "Confirm Password",
                        obscureText: true,
                        hint: "confirm your password here",
                        validator: (value) {
                          if (controller.authData['password'] != value) {
                            return "Password should be the same";
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 35,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        onPressed: () => validate(controller),
                        child: Text(
                          controller.authState.value == AuthState.signup
                              ? "Sign up"
                              : "Login",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        if (controller.authState.value == AuthState.signup) {
                          controller.setAuthState(AuthState.login);
                        } else {
                          controller.setAuthState(AuthState.signup);
                        }
                      },
                      child: Text(
                        controller.authState.value == AuthState.signup
                            ? "I have an account"
                            : "Create account",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  validate(AuthController controller) async {
    if (formKey.currentState!.validate()) {
      Get.dialog<bool>(
              AlertDialog(
                backgroundColor: Colors.white,
                title: Center(
                  child: FutureBuilder(
                    future: controller.authState.value == AuthState.signup
                        ? controller.signUp()
                        : controller.signIn(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Get.back(result: snapshot.data);
                      }
                      return const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading...')
                        ],
                      );
                    },
                  ),
                ),
              ),
              barrierDismissible: false)
          .then(
        (value) {
          if (value == true) {
            Get.offAllNamed('/home');
          }
          if (controller.errorMsg.isNotEmpty && value != true) {
            Get.showSnackbar(buildSnackBar(controller.errorMsg, Colors.red));
          }
        },
      );
    }
  }
}
