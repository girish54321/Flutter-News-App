import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/screen/homeScreen/homeMain.dart';
import 'package:newsApp/screen/splashScreen/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); //#FF2D55
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

class Palette {
  static const Color primary = Color(0xFFFF2D55);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStateProvider>(
            create: (context) => LoginStateProvider()),
      ],
      child: Consumer<LoginStateProvider>(
        builder: (context, loginStateProvider, child) {
          return MaterialApp(
              title: 'Music Players',
              theme: ThemeData(
                primarySwatch: generateMaterialColor(Palette.primary),
                scaffoldBackgroundColor: Colors.white,
              ),
              home: loginStateProvider.logedIn == true
                  ? HomeMain()
                  : SplashScreen());
        },
      ),
    );
  }
}