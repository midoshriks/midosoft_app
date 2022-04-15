// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffee444c);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // responsev kebord
      resizeToAvoidBottomInset: false,
      // responsev kebord
      body: Column(
        children: [
          isKeyboardVisible
              ? SizedBox(
                  height: screenHeight / 20,
                )
              : Container(
                  height: screenHeight / 2.5,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(70)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: screenWidth / 5,
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenHeight / 20,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "NexaBold",
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filedTitle("Employee ID"),
                customField("Enter your employee id", idController, false),
                filedTitle("Password"),
                customField("Enter your password", passController, true),
                GestureDetector(
                  onTap: () async {
                    String id = idController.text.trim();
                    String password = passController.text.trim();
                    
                    QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Employee")
                          .where('id', isEqualTo: id)
                          .get();

                      print(snap.docs[0].id);

                    // if (id.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text("Employee id is empite!"),
                    //   ));
                    // } else if(password.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text("password id is empite!"),
                    //   ));
                    // } else {
                    //   QuerySnapshot snap = await FirebaseFirestore.instance
                    //       .collection("Employee")
                    //       .where('id', isEqualTo: id)
                    //       .get();

                    //   print(snap.docs[0]['id']);
                    // }

                  },
                  child: Container(
                    height: 60,
                    width: screenWidth,
                    margin: EdgeInsets.only(top: screenHeight / 40),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 24,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filedTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "NexaLight",
        ),
      ),
    );
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscuer) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // mido
            // margin: const EdgeInsets.only(right: 18),
            // mido
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 12,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 45,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscuer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
