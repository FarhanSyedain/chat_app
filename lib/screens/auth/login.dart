import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/loginScreenBody.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
            padding: EdgeInsets.only(top: 20),
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {},
          ),
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Log in',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      
      ),
      body: LoginScreenBody(),
    );
  }
}
