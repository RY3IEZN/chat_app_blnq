import 'package:flutter/material.dart';
import 'package:flutter_chat_app_notiimagpck/main.dart';
import 'package:flutter_chat_app_notiimagpck/model/message.dart';
import 'package:flutter_chat_app_notiimagpck/utils/noti.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputContoller = TextEditingController();
  late IO.Socket socket;
  ChatContoller chatContoller = ChatContoller();

  @override
  void initState() {
    socket = IO.io(
        "http://192.168.0.232:3006",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListner();
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    msgInputContoller.dispose();
    super.dispose();
  }

  void sendMessage(String text) {
    var messageJson = {"message": text, "sentByMe": socket.id};
    socket.emit("message", messageJson);
    chatContoller.chatMessages.add(Message.fromJson(messageJson));
  }

  void setUpSocketListner() {
    socket.on("message-recieve", (data) {
      print(data);
      chatContoller.chatMessages.add(Message.fromJson(data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 238, 248, 1),

      // chatbox area
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: chatContoller.chatMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          var currentItem = chatContoller.chatMessages[index];
                          return MessageItem(
                              message: currentItem.message,
                              sentByMe: currentItem.sentByMe == socket.id);
                        },
                      ),
                    ),
                  ),

                  // the textinput box
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 246, 252, 1),
                          boxShadow: [BoxShadow(color: Colors.black)]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextField(
                          controller: msgInputContoller,
                          decoration: InputDecoration(
                            hintText: "Start typing a message...",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.15),
                            suffixIcon: Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.purple),
                              child: IconButton(
                                onPressed: () {
                                  sendMessage(msgInputContoller.text);
                                  msgInputContoller.text = "";
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Noti.showBigTextNotification(
                                      title: "sent you a message",
                                      body: "...isTyping",
                                      fln: flutterLocalNotificationsPlugin);
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          onTap: () => {
                                Noti.showBigTextNotification(
                                    title: "Private Chat",
                                    body: "A user isTyping",
                                    fln: flutterLocalNotificationsPlugin)
                              }),
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

// message-bubbles
class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.sentByMe, required this.message})
      : super(key: key);

  final bool sentByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: sentByMe ? Colors.white : Color.fromRGBO(119, 101, 196, 1),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: sentByMe
                      ? Color.fromRGBO(119, 101, 196, 1)
                      : Colors.white),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "5:00pm",
              style: TextStyle(
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
