import 'package:flutter/material.dart';
import 'package:flutter_chat_app_notiimagpck/screens/chat_screen.dart';
import 'package:flutter_chat_app_notiimagpck/screens/login_screen.dart';
import 'package:flutter_chat_app_notiimagpck/widgets/custom_cards.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {

  // tempory contactList
  List contacts = [
    ["Jenny", true, 0, 1],
    ["Jones", true, 0, 1],
    ["Peter", true, 0, 45],
    ["Solo", false, 0, 21],
    ["Alex", true, 0, 25]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 238, 248, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(119, 101, 196, 1),
        automaticallyImplyLeading: false,
        title: Text("Contact list"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("logout"),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCard(
            contactName: contacts[index][0],
            isOnline: contacts[index][1],
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen(),),);
            },
          );
        },
      ),
    );
  }
}
