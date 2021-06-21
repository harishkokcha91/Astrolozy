import 'package:astrolozy/components/custom_surfix_icon.dart';
import 'package:astrolozy/components/default_button.dart';
import 'package:astrolozy/components/form_error.dart';
import 'package:astrolozy/helper/keyboard.dart';
import 'package:astrolozy/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignInWithMobileForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpMobileFormState();
}

class _SignUpMobileFormState extends State<SignInWithMobileForm> {
  final _formKey = GlobalKey<FormState>();
  String mobile;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildMobileFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print(mobile);
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                Navigator.pushNamed(context, OtpScreen.routeName,arguments:mobile);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      obscureText: false,
      maxLength: 10,
      keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
      onSaved: (newValue) => mobile = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        } else if (value.length <= 10) {
          removeError(error: kShortMobileError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kShortMobileError);
          return "";
        }
        removeError(error: kShortMobileError);
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mobile",
        hintText: "Enter your Mobile",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }
}
