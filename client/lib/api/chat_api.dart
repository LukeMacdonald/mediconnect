import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';

import '../../utilities/imports.dart';

class ChatAPI{

  static Future<http.Response> menu(int senderID){
    var response = await http.get(
        Uri.parse("$SERVERDOMAIN/messages/menu?senderID=$senderID"),
        headers: {'Content-Type': 'application/json'});
    return response;
  }

  static Future<http.Response> post(int senderID, int receiverID, String message){
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);

    var response =  await http.post(Uri.parse("$SERVERDOMAIN/messages/post"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'senderID': senderID,
          'receiverID': receiverID,
          'timestamp': formattedDate,
          'message': message,
          'viewed': false,
        }));
    return response
  }

  static Future<http.Response> unread(int senderID, int receiverID){
    var response = await http.get(
        Uri.parse("$SERVERDOMAIN/messages/unread?senderID=${senderID}&receiverID=${receiverID}"),
        headers: {'Content-Type': 'application/json'});

    return response;
  }

  static Future<http.Response> delete(int userID){
    var response = await http.delete(
        Uri.parse("$SERVERDOMAIN/message?userID=${userID}"),
        headers: {'Content-Type': 'application/json'});

    return response;

  }
}