import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'alerts.dart';

class ProfileTile extends StatefulWidget {
  final User user;
  const ProfileTile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileTileState createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 250,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Account Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Name: ${widget.user.firstName} ${widget.user.lastName}",style: TextStyle(fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Email: ${widget.user.email}", style: const TextStyle(fontSize: 14)),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Role: ${widget.user.role}", style: const TextStyle(fontSize: 14)),
                    ),
                ],),
              ),
              IconButton(onPressed: (){
                deleteAccount(widget.user.email,widget.user.role, context);
              }, icon: const Icon(CupertinoIcons.delete_solid))
            ],
          ),
        ),
      ),
    );
  }
}
