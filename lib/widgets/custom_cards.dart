import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.contactName,
    required this.onTap,
    required this.isOnline,
  }) : super(key: key);

  final String contactName;
  final VoidCallback onTap;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset.zero)
            ],
            color: Color.fromRGBO(234, 231, 246, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      radius: 20,
                      foregroundImage: NetworkImage(
                          "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contactName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(isOnline ? "Online 🟢" : "Offline ⭕")
                    ],
                  ),
                ],
              ),
              Icon(Icons.chat)
            ],
          ),
        ),
      ),
    );
  }
}
