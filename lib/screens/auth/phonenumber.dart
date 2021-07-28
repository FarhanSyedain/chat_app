import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:chat_app/screens/auth/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      'Phone Number',
                      'Enter a valid phone number',
                      (v) {
                        if (v == null) {
                          return null;
                        }
                        return v.length == 10
                            ? null
                            : 'Please enter a valid phone number';
                      },
                      controller: _controller,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: CustomProceedButton('Get OTP'),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OTPScreen('+91${_controller.text}');
                            },
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
