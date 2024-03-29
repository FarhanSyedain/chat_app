// import '/screens/auth/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class PhoneNumberInput extends StatelessWidget {
//   final number;
//   final changeVal;
//   PhoneNumberInput(this.number, this.changeVal);

//   @override
//   Widget build(BuildContext context) {
//     return InternationalPhoneNumberInput(
//       initialValue: number,
//       autoFocus: true,
//       countrySelectorScrollControlled: false,
//       scrollPadding: EdgeInsets.all(0),
//       selectorTextStyle: Theme.of(context).textTheme.bodyText2,
//       autoValidateMode: AutovalidateMode.always,
//       searchBoxDecoration: InputDecoration(
//         filled: true,
//         fillColor: Theme.of(context).backgroundColor,
//         enabledBorder: unFocusedBorder(context),
//         focusedBorder: focusedBorder(context),
//       ),
//       selectorConfig: SelectorConfig(
//         leadingPadding: 0,
//         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//         useEmoji: true,
//         setSelectorButtonAsPrefixIcon: true,
//         trailingSpace: false,
//       ),
//       textStyle: Theme.of(context).textTheme.bodyText1,
//       spaceBetweenSelectorAndTextField: 5,
//       ignoreBlank: true,
//       onInputChanged: (phoneNumber) {
//         changeVal(phoneNumber);
//       },
//       inputDecoration: InputDecoration(
//         focusedErrorBorder: unFocusedBorder(context, isError: true),
//         errorBorder: unFocusedBorder(context, isError: true),
//         hintText: 'Phone Number',
//         hintStyle: Theme.of(context).textTheme.bodyText2,
//         focusedBorder: focusedBorder(context),
//         enabledBorder: unFocusedBorder(context),
//       ),
//     );
//   }
// }
