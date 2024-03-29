import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSize buildAppBar(context,
        {String? title,
        void Function()? back,
        showBackButton = true,
        paddingTop = 20.0,
        bgColor,
        height = 60.0,
        titleWidget,
        leading,
        statusBarColor,
        titleStyle,
        elevation,
        leadingWidth,
        bottom,
        paddingBottom = 15.0,
        List<Widget>? actions}) =>
    PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        automaticallyImplyLeading: false,
        bottom: bottom,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: bgColor ?? Theme.of(context).backgroundColor,
        leading: showBackButton
            ? IconButton(
                padding:
                    EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: back ?? () {
                        Navigator.of(context).pop();
                      },
              )
            : leading,

        actions: actions,
        // centerTitle: showBackButton ? false : true,
        toolbarHeight: height,
        elevation: 0,
        shadowColor: Theme.of(context).cardColor,
        title: titleWidget ?? (title != null
                ? Padding(
                    padding:
                        EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
                    child: Text(
                      title,
                      style:
                          titleStyle ?? Theme.of(context).textTheme.headline1,
                    ),
                  )
                : null),
      ),
    );
