import 'dart:convert';
import 'package:admin_panel/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(hintText: "Notification Title"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(hintText: "Notification Body"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              onPressed: () {
                if(_body.text.isNotEmpty && _title.text.isNotEmpty){
                                  sendNotificationToAllUsers(appProvider.getUsersToken ,_title.text ,_body.text);
                                  _title.clear();
                                  _body.clear();

                }else{
                  showMessage("Fill The details");
                }

              },
              child: const Text("Send Notification"),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> sendNotificationToAllUsers(List<String?> usersToken ,String title , String body) async {
      List<String> newAllUserToken =[];

    List<String> allUserToken =[];
    for(var element in usersToken){
      if(element != null || element != ""){
        newAllUserToken.add(element!);

      }
    }
    allUserToken = newAllUserToken;
  const String serverKey =
      "AAAAhYW7aT8:APA91bG4KGoxpHRnIUWcTr6jMQ2bb2d0K-7P4f5CfGzX7fxLr9GgjG5Oz927djtxrZBT0i1VEk1F5_I8DjHnGTV4ztLBq1fdRUkZ8wqx1dF8DNbj_BXqPh-GzLrSEgJjkuHxep2kM0tx";
  const String firebaseUrl = "https://fcm.googleapis.com/fcm/send";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key =$serverKey',
  };
  final Map<String, dynamic> notification = {
    'title': title,
    'body': body,
  };

  final Map<String, dynamic> requestBody = {
    'notification': notification,
    'priority': 'high',
    'registration_ids': allUserToken,
  };

  final String encodedBody = jsonEncode(requestBody);
  final http.Response response = await http.post(
    Uri.parse(firebaseUrl),
    headers: headers,
    body: encodedBody,
  );

  if (response.statusCode == 200) {
    print('Notification sent Success');
  } else {
    print("Notification sending failed with status : ${response.statusCode}");
  }
}
