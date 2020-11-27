import 'package:flutter/material.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/screen/homeScreen/homeMain.dart';
import 'package:newsApp/widgets/appButton.dart';
import 'package:newsApp/widgets/inputText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class SingUpUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final Function createNewUser;

  const SingUpUi(
      {Key key,
      @required this.emailController,
      @required this.passwordController,
      @required this.userNameController,
      @required this.createNewUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        "NEWS 360",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Bebas Neue",
                          fontSize: 41,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    InputText(
                        password: false,
                        hint: "Email",
                        textEditingController: emailController,
                        validator: (email) {
                          final emailRule = Rule(email,
                              name: 'Email', isRequired: true, isEmail: true);
                          if (emailRule.hasError) {
                            return emailRule.error;
                          } else {
                            return null;
                          }
                        }),
                    InputText(
                        textEditingController: userNameController,
                        password: false,
                        hint: "Name",
                        validator: (password) {
                          final passWordRule = Rule(password,
                              name: 'Name', isRequired: true, minLength: 6);
                          if (passWordRule.hasError) {
                            return passWordRule.error;
                          } else {
                            return null;
                          }
                        }),
                    InputText(
                        textEditingController: passwordController,
                        password: true,
                        hint: "Password",
                        validator: (password) {
                          final passWordRule = Rule(password,
                              name: 'Password', isRequired: true, minLength: 6);
                          if (passWordRule.hasError) {
                            return passWordRule.error;
                          } else {
                            return null;
                          }
                        }),
                    InputText(
                        textEditingController: passwordController,
                        password: false,
                        hint: "Confirm Password",
                        validator: (password) {
                          final passWordRule = Rule(password,
                              name: 'Confirm Password',
                              isRequired: true,
                              minLength: 6);
                          if (passWordRule.hasError) {
                            return passWordRule.error;
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 8),
                    Consumer<LoginStateProvider>(
                      builder: (context, loginStateProvider, child) {
                        return Center(
                          child: Container(
                            height: 45.33,
                            width: 195.19,
                            child: AppButton(
                              buttonText: "Sing Up",
                              function: () {
                                if (_formKey.currentState.validate()) {
                                  createNewUser(loginStateProvider.addUser);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
