import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';

class NewChat extends StatefulWidget {
  const NewChat({Key? key}) : super(key: key);

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  late List<MessageData> _messages;
  late List<String> _names;
  late List<dynamic> _doctors;

  @override
  void initState() {
    _messages = [];
    _names = [];
    _doctors = [];
    getDoctors();
    super.initState();
  }

  Future<void> getDoctors() async {
    try {
      String role = "";
      await UserSecureStorage.getRole().then((value) => role = value!);
      if (role == "patient") {
        String id = "";
        await UserSecureStorage.getID().then((value) => id = value!);
        var response = await http.get(
            Uri.parse(
                "${appointmentIP}search/appointment_doctors/${int.parse(id)}"),
            headers: {'Content-Type': 'application/json'});
        switch (response.statusCode) {
          case 200:
            _doctors = json.decode(response.body) as List;
            for (int i = 0; i < _doctors.length; i++) {
              _messages.add(MessageData(
                  null, int.parse(id), _doctors[i], DateTime.now(), "", false));
              response = await http.get(
                  Uri.parse("${authenticationIP}get/name/${_doctors[i]}"),
                  headers: {'Content-Type': 'application/json'});
              _names.add(response.body);
            }
            setState(() {});
            break;
          default:
            var list = json.decode(response.body).values.toList();
            throw Exception(list.join("\n\n"));
        }
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text("New Message"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Available Doctors to Message",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return ChatTile(
                            messageData: _messages[index],
                            name: _names[index],
                          );
                        },
                      ))),
            ]));
  }
}
