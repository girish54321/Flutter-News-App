import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/Compontes/dialogs.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/screen/changePassword/changePasswordScreen.dart';
import 'package:newsApp/screen/splashScreen/SplashScreen.dart';
import 'package:newsApp/widgets/listTitleText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SETTINGS",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: ListTileText(
              text: "Notification",
            ),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: ListTileText(
              text: "Change Password",
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChangePasswordScreen()));
            },
          ),
          Consumer<LoginStateProvider>(
            builder: (context, loginStateProvider, child) {
              return ListTile(
                title: ListTileText(
                  text: "Logout",
                ),
                onTap: () async {
                  final action = await Dialogs.yesAbortDialog(
                      context, 'Log Out', 'Are You Sure ?');
                  if (action == DialogAction.yes) {
                    await FirebaseAuth.instance.signOut();
                    loginStateProvider.changeLoginState(false);
                    // Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen(),
                      ),
                      (route) => false,
                    );
                  } else {}
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
