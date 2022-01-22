import 'dart:io';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/chats.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:chat_app/utilities/validitors/basicFormValiditors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AddPerson extends StatefulWidget {
  final Function changeIndex;
  AddPerson(this.changeIndex);
  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'MontserratB',
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Enter a valid email,',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  'Email',
                  emailValidator,
                  controller: _controller,
                  errorMessage: errorMessage,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: CustomProceedButton('Add Person'),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final email = _controller.text;
                      setState(() {
                        isLoading = true;
                        errorMessage = '';
                      });
                      FirebaseFirestore.instance
                          .collection('users')
                          .where('email', isEqualTo: email)
                          .get()
                          .then(
                        (value) {
                          if (value.docs.isEmpty) {
                            setState(() {
                              isLoading = false;
                              errorMessage = 'No user with this email exists';
                            });
                          } else {
                            final id = value.docs.first.id;
                            final data = value.docs.first.data();
                            final name = data['firstName'];
                            final email = data['email'];
                            final bio = data['bio'];
                            File? profilePicture;
                            FirebaseStorage.instance
                                .ref()
                                .child('userProfiles')
                                .child(id)
                                .getData()
                                .then((value) {})
                                .catchError((error) {})
                                .whenComplete(
                              () {
                                final chat = Chat.fromdata(
                                  id,
                                  name,
                                  email,
                                  profilePicture,
                                  bio,
                                  DateTime.now(),
                                );
                                Provider.of<Chats>(context, listen: false)
                                    .addtoChats(chat);
                                setState(() {
                                  isLoading = false;
                                });
                                _controller.clear();
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                widget.changeIndex(2);
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
