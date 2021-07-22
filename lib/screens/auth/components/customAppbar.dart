import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSize buildAppBar(context, {String? title, void Function()? back}) =>
    PreferredSize(
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
          onPressed: back ?? () => Navigator.pop(context),
        ),
        elevation: 0,
        title: title != null
            ? Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              )
            : null,
      ),
    );
