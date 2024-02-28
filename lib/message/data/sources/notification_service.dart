import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/message/presention/message_screen.dart';
import 'package:travelling_app/signup/data/models/user.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  void sendPushNotify({required String msg, required UserModel receiver, required UserModel sender}) async {
    final body = {
      'to': receiver.deviceToken,
      'notification': {
        'title': sender.name,
        'body': msg,
      },
      'data': {
        'email': receiver.email,
        'uid': receiver.uid,
        'name': receiver.name,
        'password': receiver.pass,
        'urlAvatar': receiver.urlAvatar,
        'deviceToken': receiver.deviceToken,
      }
    };
    try {
      var res = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), body: jsonEncode(body), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'key=AAAAmHKx-84:APA91bGGzrWvkXUwfqHqeNaewY4PJ8H_MjFecmvF-XE3aerwZtiSFDNVLv7Ij0joHC5dT98JNnTEvlEBdxYOfhpIovtVmqYXFCocUfN9QiFF862tQDWyDg08_Dr8lfCGjCzeHoyGQOvH',
      });
      print(res.statusCode);
      print(res.body);
    } catch (e) {
      print(e);
    }
  }

  void receiveNotify() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
