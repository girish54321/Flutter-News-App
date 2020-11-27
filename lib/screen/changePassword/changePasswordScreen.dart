import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/helper/helper.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/widgets/appButton.dart';
import 'package:newsApp/widgets/inputText.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void _changePassword() async {
    User user = FirebaseAuth.instance.currentUser;
    user.updatePassword(newPasswordController.text.trim()).then((_) {
      print("Succesfull changed password");
      Helper().showSnackBar(
          "Succesfull changed password", "Password Changed", context, false);
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      Helper()
          .showSnackBar("Password can't be changed", "Error", context, true);
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "CHANGE PASSWORD",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        body: LayoutBuilder(
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
                      children: [
                        SizedBox(height: 16),
                        InputText(
                            textEditingController: newPasswordController,
                            password: true,
                            hint: "New Password",
                            validator: (password) {
                              final passWordRule = Rule(password,
                                  name: 'Password',
                                  isRequired: true,
                                  minLength: 6);
                              if (passWordRule.hasError) {
                                return passWordRule.error;
                              } else {
                                return null;
                              }
                            }),
                        InputText(
                            textEditingController: confirmNewPasswordController,
                            password: true,
                            hint: "Confirm New Password",
                            validator: (password) {
                              final passWordRule = Rule(password,
                                  name: 'Confirm Password',
                                  shouldMatch:
                                      newPasswordController.text.trim(),
                                  isRequired: true,
                                  minLength: 6);
                              if (passWordRule.hasError) {
                                return passWordRule.error;
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        SizedBox(height: 8),
                        Consumer<LoginStateProvider>(
                          builder: (context, loginStateProvider, child) {
                            return Center(
                              child: Container(
                                height: 45.33,
                                width: 195.19,
                                child: AppButton(
                                  buttonText: "Update",
                                  function: () {
                                    if (_formKey.currentState.validate()) {
                                      _changePassword();
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
