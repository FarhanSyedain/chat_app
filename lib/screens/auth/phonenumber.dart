import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/constants.dart';
import 'package:chat_app/screens/auth/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SvgPicture.asset(
              'assets/vectors/phoneAuth.svg',
              height: MediaQuery.of(context).size.height / 3,
            ),
            SizedBox(height: 20),
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: InternationalPhoneNumberInput(
                      initialValue: number,
                      countrySelectorScrollControlled: false,
                      scrollPadding: EdgeInsets.all(0),
                      selectorTextStyle: Theme.of(context).textTheme.bodyText2,
                      autoValidateMode: AutovalidateMode.always,
                      searchBoxDecoration: InputDecoration(
                        enabledBorder: unFocusedBorder(context),
                        focusedBorder: focusedBorder(context),
                      ),
                      selectorConfig: SelectorConfig(
                        leadingPadding: 0,
                        selectorType: PhoneInputSelectorType.DIALOG,
                        useEmoji: true,
                        setSelectorButtonAsPrefixIcon: true,
                        trailingSpace: false,
                      ),
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      spaceBetweenSelectorAndTextField: 5,
                      ignoreBlank: true,
                      onInputChanged: (phoneNumber) {
                        number = phoneNumber;
                      },
                      inputDecoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: Theme.of(context).textTheme.bodyText2,
                        focusedBorder: focusedBorder(context),
                        enabledBorder: unFocusedBorder(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    child: CustomProceedButton('Get OTP'),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OTPScreen('${number.phoneNumber}');
                            },
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text('Use Email instead?'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
