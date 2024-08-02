import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_project/ui/home/home_screen.dart';

import '../../utils/color_resource/color_resources.dart';
import '../../utils/coustom_bottom.dart';
import '../../utils/coustom_text_form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: "Mayada");

  TextEditingController emailController =
      TextEditingController(text: "Mayada@gmail.com");

  TextEditingController phoneController =
      TextEditingController(text: "0123456789");

  TextEditingController passwordController =
      TextEditingController(text: "123456");

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
                        userTextColor: Colors.black,
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
                        userTextColor: Colors.black,
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
                        userTextColor: Colors.black,
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
                        userTextColor: ColorResources.primaryLightColor,
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
                          onTap: () async {
                            await registerUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                            setState(() {});
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

  Future<void> registerUser() async {
    if (formKey.currentState!.validate() == true) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: ${e.toString()}')),
        );
      }
    }
  }
}
