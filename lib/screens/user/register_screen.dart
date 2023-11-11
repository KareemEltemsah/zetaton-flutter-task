import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_flutter_task/models/user/user_model.dart';
import 'package:zetaton_flutter_task/screens/user/login_screen.dart';

import '../../common/tools.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

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
                            /// empty
                            return 'first name is required';
                          } else if (value.trim().length < 3) {
                            /// very short
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
                            /// empty
                            return 'last name is required';
                          } else if (value.trim().length < 3) {
                            /// very short
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
                            /// empty
                            return 'email is required';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            /// not a valid email
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
                            /// empty
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
                            /// empty
                            return 'password is required';
                          } else if (value.length < 6) {
                            /// very short
                            return 'should be at least 6 characters';
                          }
                        },
                      ),

                      /// register button
                      AppButton(
                        title: "Register",
                        enabled: true,
                        onTap: () => submitRegister(context),
                      ),

                      /// already have an account ?
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Already have an account?'),
                            InkWell(
                              onTap: () {
                                /// navigate to register screen
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                              child: Text(
                                ' login',
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

  submitRegister(context) async {
    try {
      /// validate register form
      if (!formKey.currentState!.validate()) return;

      /// call register function
      await Provider.of<UserModel>(context, listen: false).registerUser(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );

      /// navigate to login screen
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } catch (e) {
      Tools.showSnackBar(context, e.toString());
    }
  }
}
