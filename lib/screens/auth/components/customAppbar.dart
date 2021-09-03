import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSize buildAppBar(
  context, {
  String? title,
  void Function()? back,
  showBackButton = true,
  paddingTop = 20.0,
  bgColor,
  height,
  leading,
  statusBarColor,
  elevation,
  leadingWidth,
List<Widget>? actions 
}) =>
    PreferredSize(
      preferredSize: Size.fromHeight(height ?? 70.0),
      child: AppBar(
      
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: statusBarColor ?? Theme.of(context).cardColor,
        ),
        backgroundColor: bgColor ?? Theme.of(context).backgroundColor,
        leading: showBackButton
            ? IconButton(
                padding: EdgeInsets.only(top: paddingTop),
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: back,
              )
            :  leading,
          
            actions:actions,
        // centerTitle: showBackButton ? false : true,
        elevation: elevation ?? 0,
        
        title: title != null
            ? Padding(
                padding: EdgeInsets.only(top: paddingTop),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              )
            : null,
      ),
    );
