import 'package:chat_app/screens/auth/login.dart';
import 'package:chat_app/screens/auth/register.dart';
import 'package:chat_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      // todo: Theming
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
