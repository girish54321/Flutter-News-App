import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/helper/helper.dart';
import 'package:newsApp/screen/auth/loginScreen/loginUi.dart';
import 'package:newsApp/screen/homeScreen/homeMain.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ignore: missing_return
  Future<UserCredential> signInWithGoogle(Function createUser) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential newUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      createUser(newUser.user.uid, newUser.user.displayName, newUser.user.email,
          newUser.user.photoURL);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeMain(),
        ),
        (route) => false,
      );
    } catch (e) {
      Helper().showSnackBar(e.toString(), "ERROR", context, true);
    }
  }

  comeingSoonMssage(text) {
    Helper().showSnackBar('Coming Soon', text, context, true);
  }

  userLogin(Function getUserData) async {
    await Helper().showLoadingDilog(context).show();
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      await Helper().showLoadingDilog(context).hide();
      getUserData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeMain(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      await Helper().showLoadingDilog(context).hide();
      if (e.code == 'user-not-found') {
        Helper().showSnackBar(
            'No user found for that email.', 'error', context, true);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Helper().showSnackBar(
            'Wrong password provided for that user.', 'error', context, true);
      }
    } catch (e) {
      await Helper().showLoadingDilog(context).hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginUi(
          comeingSoonMssage: comeingSoonMssage,
          emailController: emailController,
          userLogin: userLogin,
          passwordController: passwordController,
          signInWithGoogle: signInWithGoogle),
    );
  }
}
