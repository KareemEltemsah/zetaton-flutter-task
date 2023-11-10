import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: <Widget>[
                /// register form
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 30.0),

                      /// first name field
                      CustomTextField(
                        controller: firstNameController,
                        type: TextInputType.name,
                        label: "First Name",
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'first name is required';
                          } else if (value.length < 3) {
                            return 'should be at least 3 letters';
                          }
                        },
                      ),

                      /// last name field
                      CustomTextField(
                        controller: lastNameController,
                        type: TextInputType.name,
                        label: "Last Name",
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'last name is required';
                          } else if (value.length < 3) {
                            return 'should be at least 3 letters';
                          }
                        },
                      ),

                      /// email field
                      CustomTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: "Email",
                        prefix: Icons.email_outlined,
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'email is required';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'please enter a valid email';
                          }
                        },
                      ),

                      /// phone field
                      CustomTextField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: "Phone",
                        prefix: Icons.phone_outlined,
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'phone is required';
                          }
                        },
                      ),

                      /// password field
                      CustomTextField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: "Password",
                        prefix: Icons.lock_outlined,
                        password: true,
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'password is required';
                          } else if (value.length < 6) {
                            return 'should be at least 6 characters';
                          }
                        },
                      ),

                      /// register button
                      AppButton(
                        title: "Register",
                        enabled: true,
                        onTap: submitRegister,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitRegister() {}
}
