import 'package:flutter/material.dart';
import 'package:astrolozy/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as String;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(todo),
    );
  }
}
