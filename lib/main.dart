import '/screens/auth/login/confirmEmail.dart';
import '/screens/auth/phoneAuth/phonenumber.dart';
import '/screens/auth/login/resetEmail.dart';
import '/screens/auth/login/resetPassword.dart';
import '/screens/auth/wrapper.dart';
import '/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'screens/auth/login/login.dart';
import 'screens/auth/register/register.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType =null;
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
          '/resetEmailSend': (context) => ResetEmailSendScreen(),
          '/forgotPassword': (context) => ResetEmailScreen(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}
