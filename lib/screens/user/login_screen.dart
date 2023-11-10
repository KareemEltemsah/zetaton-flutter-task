import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: <Widget>[
                /// login form
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 30.0),

                      /// email field
                      CustomTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: "Email",
                        prefix: Icons.email_outlined,
                        validateFunc: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'please enter a valid email';
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
                            return 'please enter your password';
                          }
                        },
                      ),

                      /// login button
                      AppButton(
                        title: "Login",
                        enabled: true,
                        onTap: submitLogin,
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

  submitLogin() {}
}
