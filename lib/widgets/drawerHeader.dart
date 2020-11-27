import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/screen/changePassword/changePasswordScreen.dart';
import 'package:newsApp/screen/settingScreen/settingsScreen.dart';
import 'package:page_transition/page_transition.dart';

import 'listTitleText.dart';

class DrawerHeaderView extends StatelessWidget {
  Widget listItem(String text, context, Widget icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        leading: icon,
        title: ListTileText(text: text),
        onTap: () {
          switch (text) {
            case 'Settings':
              {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SettingScreen()));
              }
              break;

            case 'Change Password':
              {
                //statements;
              }
              break;

            default:
              {}
              break;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                height: 140,
                child: Center(
                  child: ListTile(
                    title: ListTileText(text: "Girish Parate"),
                    subtitle: ListTileText(text: "Mobile App Devloper"),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  ),
                ),
              ),
            ),
            listItem(
                "Home",
                context,
                Icon(
                  FluentIcons.home_20_regular,
                  color: Theme.of(context).accentColor,
                )),
            listItem(
                "Bookmarks",
                context,
                Icon(
                  FluentIcons.bookmark_20_regular,
                  color: Theme.of(context).accentColor,
                )),
            listItem(
                "Settings",
                context,
                Icon(
                  FluentIcons.settings_20_regular,
                  color: Theme.of(context).accentColor,
                )),
            listItem(
                "About",
                context,
                Icon(
                  FluentIcons.info_20_regular,
                  color: Theme.of(context).accentColor,
                )),
            listItem(
                "Invite Friends",
                context,
                Icon(
                  FluentIcons.share_20_regular,
                  color: Theme.of(context).accentColor,
                )),
            listItem(
                "Rate Us",
                context,
                Icon(
                  FluentIcons.star_20_regular,
                  color: Theme.of(context).accentColor,
                )),
          ],
        ),
      ),
    );
  }
}
