import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/screen/admin/addNewPost.dart';
import 'package:newsApp/screen/settingScreen/settingsScreen.dart';
import 'package:newsApp/widgets/articleListItem.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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

            case 'Add New Post':
              {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AddNewPost()));
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
    return Consumer<LoginStateProvider>(
      builder: (context, loginStateProvider, child) {
        return Drawer(
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 22,
                ),
                SafeArea(
                  child: ListTile(
                    leading: loginStateProvider.user.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: loginStateProvider.user.imageUrl,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 42,
                                ),
                            placeholder: (context, url) => LodingImage())
                        : CircleAvatar(
                            radius: 42,
                            child: Center(
                              child: Text(loginStateProvider.user.userName[0]),
                            ),
                          ),
                    title: ListTileText(text: loginStateProvider.user.userName),
                    subtitle: ListTileText(text: loginStateProvider.user.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                ),
                Divider(),
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
                loginStateProvider.user.admin
                    ? listItem(
                        "Add New Post",
                        context,
                        Icon(
                          FluentIcons.notebook_24_regular,
                          color: Theme.of(context).accentColor,
                        ))
                    : SizedBox(
                        height: 1,
                      ),
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
      },
    );
  }
}
