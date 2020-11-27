import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/widgets/appButton.dart';
import 'package:newsApp/widgets/inputText.dart';
import 'package:newsApp/widgets/socailButton.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';

class LoginUi extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function userLogin;
  final Function signInWithGoogle;
  final Function comeingSoonMssage;

  const LoginUi(
      {Key key,
      @required this.emailController,
      @required this.passwordController,
      @required this.userLogin,
      this.signInWithGoogle,
      this.comeingSoonMssage})
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
                    SizedBox(height: 22),
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
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: new Text(
                        "Forgot Password?\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Consumer<LoginStateProvider>(
                      builder: (context, loginStateProvider, child) {
                        return Center(
                          child: Container(
                            height: 45.33,
                            width: 195.19,
                            child: AppButton(
                              buttonText: "Log In",
                              function: () {
                                if (_formKey.currentState.validate()) {
                                  userLogin();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 18),
                    Center(
                      child: Text(
                        "Or login with",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nexa Slab Bold",
                          fontSize: 14,
                          color: Color(0xff767676),
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Consumer<LoginStateProvider>(
                      builder: (context, loginStateProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SosailButton(
                                function: () {
                                  comeingSoonMssage("Facebook");
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                )),
                            SosailButton(
                                function: () {
                                  signInWithGoogle(loginStateProvider.addUser);
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                )),
                            SosailButton(
                                function: () {
                                  comeingSoonMssage("Twitter");
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                )),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 18),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: SingUpScreen()));
                      },
                      child: Center(
                        child: Text(
                          "Sign up with email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Nexa Slab Bold",
                            fontSize: 14,
                            color: Color(0xff767676),
                          ),
                        ),
                      ),
                    ),
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
