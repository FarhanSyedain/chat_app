import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../chat/loadingOverlay.dart';
import '../../auth/components/customAppbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(
          context,
          title: 'Account',
        ),
        body: Body(changeIsLoading),
      ),
    );
  }

  changeIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
