import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_project/ui/home/home_screen.dart';

import '../../utils/color_resource/color_resources.dart';
import '../../utils/coustom_bottom.dart';
import '../../utils/coustom_text_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.bgLightColor,
        body: Stack(children: [
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
                physics: const BouncingScrollPhysics(),
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
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      CoustomTextForm(
                        controller: nameController,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "field your name";
                          }
                          return null;
                        },
                        label: "Your Name",
                        text: TextInputType.text,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 10,
                        labelColor: Colors.grey,
                        userTextColor: Colors.grey,
                        prefIcon: Icons.person,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomTextForm(
                        controller: emailController,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "field your Email";
                          }
                          return null;
                        },
                        label: "Email",
                        text: TextInputType.emailAddress,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 10,
                        labelColor: Colors.grey,
                        userTextColor: Colors.grey,
                        prefIcon: Icons.email_outlined,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomTextForm(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field your Number";
                          }
                          return null;
                        },
                        label: "Your Phone Number",
                        text: TextInputType.number,
                        museTextColor: Colors.blue,
                        borderColor: Colors.blue,
                        borderReduse: 10,
                        labelColor: Colors.grey,
                        userTextColor: Colors.grey,
                        prefIcon: Icons.phone_android_outlined,
                        prefIconColor: Colors.blue,
                        passwordText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomTextForm(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field your password";
                          }
                          return null;
                        },
                        passwordText: showPassword,
                        label: "New Password",
                        text: TextInputType.visiblePassword,
                        museTextColor: ColorResources.primaryLightColor,
                        borderColor: ColorResources.primaryLightColor,
                        borderReduse: 10,
                        labelColor: Colors.grey,
                        userTextColor: Colors.grey,
                        suffixIcone: IconButton(
                            onPressed: () {
                              showPassword = !showPassword;
                              setState(() {});
                            },
                            icon: showPassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined)),
                        prefIcon: Icons.lock,
                        prefIconColor: Colors.blue,
                        suffixIconeColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      coustomBottom(
                          textColor: ColorResources.white,
                          bgColor: ColorResources.primaryLightColor,
                          onTap: () {
                            registerUser();
                          },
                          text: "Register"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Have Account ?",
                            style: TextStyle(
                                color: ColorResources.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: ColorResources.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  void registerUser() async {
    if (formKey.currentState!.validate() == true) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Create Account Sucssesfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to register: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
