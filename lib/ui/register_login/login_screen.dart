import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_project/ui/home/home_screen.dart';
import 'package:todo_app_project/ui/register_login/register_screen.dart';
import 'package:todo_app_project/utils/color_resource/color_resources.dart';

import '../../utils/coustom_bottom.dart';
import '../../utils/coustom_text_form.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgLightColor,
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: ColorResources.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      CoustomTextForm(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return "Please Enter your Email Address";
                            } else {
                              return null;
                            }
                          },
                          prefIcon: Icons.email_outlined,
                          prefIconColor: Colors.blue,
                          controller: emailController,
                          passwordText: false,
                          label: "Email",
                          text: TextInputType.emailAddress,
                          museTextColor: Colors.white,
                          borderColor: Colors.blue,
                          borderReduse: 10,
                          labelColor: Colors.grey,
                          userTextColor: Colors.black),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomTextForm(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "Password is too Short";
                          } else {
                            return null;
                          }
                        },
                        suffixIcone: IconButton(
                            onPressed: () {
                              showPassword = !showPassword;
                              setState(() {});
                            },
                            icon: showPassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined)),
                        suffixIconeColor: Colors.blue,
                        prefIconColor: Colors.blue,
                        prefIcon: Icons.lock_outline,
                        controller: passwordController,
                        passwordText: showPassword,
                        label: "Password",
                        text: TextInputType.visiblePassword,
                        museTextColor: Colors.grey,
                        borderColor: Colors.blue,
                        borderReduse: 10,
                        labelColor: Colors.grey,
                        userTextColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      coustomBottom(
                          textColor: ColorResources.white,
                          bgColor: ColorResources.primaryLightColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          text: "LOGIN"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don`t Have Account ?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              loginUser();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              "Register Now",
                              style: TextStyle(
                                  color: ColorResources.primaryLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loginUser() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Login Sucssesfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ), (route) {
          return false;
        });
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to login: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
