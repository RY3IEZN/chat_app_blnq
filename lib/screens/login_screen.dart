import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_notiimagpck/screens/chat_screen.dart';
import 'package:flutter_chat_app_notiimagpck/screens/contact_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameTextContoller = TextEditingController();
  String? theName;
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connectUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userNameTextContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 238, 248, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hi, there",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple),
            ),
            Text(
              "Login with your username and get started",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple),
            ),

            // textinput field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: userNameTextContoller,
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Username",
                  focusColor: Colors.purple,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple, width: 1),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.purpleAccent, width: 1),
                  ),
                ),
              ),
            ),

            // button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  theName = userNameTextContoller.text;
                  isLoggedIn = true;
                  print(theName);
                  userNameTextContoller.text = "";
                  Timer(Duration(seconds: 1), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactListScreen(),
                      ),
                    );
                    print("Yeah, this line is printed after 3 seconds");
                  },);
                },);
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(119, 101, 196, 1),
              ),
            ),

            isLoggedIn
                ? Text(" Signing in as ${theName.toString()}")
                : Text(""),
          ],
        ),
      ),
    );
  }
}
