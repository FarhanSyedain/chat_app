import 'package:chat_app/screens/auth/confirmEmail.dart';
import 'package:chat_app/screens/auth/phonenumber.dart';
import 'package:chat_app/screens/auth/wrapper.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.dark,
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => Container(),
          '/verifyEmail': (context) => ConfirmEmailScreen(),
          '/wrapper': (context) => Wrapper(),
          '/phoneAuth': (context) => PhoneNumberScreen(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, data) {
        return Wrapper(profileSet: data.data as bool);
      },
      future: getSharedPrefs(),
    );
  }

  Future<bool?> getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('profileSet') == false
        ? false
        : prefs.getBool('profileSet');
  }
}
