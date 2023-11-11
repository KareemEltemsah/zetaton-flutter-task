import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_flutter_task/screens/user/register_screen.dart';

import '../../common/tools.dart';
import '../../models/user/user_model.dart';
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
                            /// empty
                            return 'please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            /// not a valid email
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
                            /// empty
                            return 'please enter your password';
                          }
                        },
                      ),

                      /// login button
                      AppButton(
                        title: "Login",
                        enabled: true,
                        onTap: () => submitLogin(context),
                      ),

                      /// don't have an account ?
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('You don\'t have an account?'),
                            InkWell(
                              onTap: () {
                                /// navigate to register screen
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ));
                              },
                              child: Text(
                                ' register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  submitLogin(context) async {
    try {
      /// validate register form
      if (!formKey.currentState!.validate()) return;

      /// call login function
      await Provider.of<UserModel>(context, listen: false).login(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      Tools.showSnackBar(context, e.toString());
    }
  }
}
