import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/utilities/imports.dart';

class ProfileTile extends StatefulWidget {
  final User user;
  const ProfileTile({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileTile> createState() => _ProfileTile();
}

class _ProfileTile extends State<ProfileTile> {

  Future<String?> deleteAccount(String email,String role, BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: const Text("Are you sure you want to remove account?"), actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await deleteProfile(email);
                  if(!mounted)return;
                  navigate(RemoveProfile(role: role), context);
                },
                child: const Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Cancel'),
              ),
            ]));
  }

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
                    child: Text("Name: ${widget.user.firstName} ${widget.user.lastName}",style: const TextStyle(fontSize: 14)),
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

class PatientTile extends StatefulWidget {
  final User user;
  final int id;
  const PatientTile({Key? key, required this.user, required this.id}) : super(key: key);

  @override
  State<PatientTile> createState() => _PatientTile();
}

class _PatientTile extends State<PatientTile> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom:20,left:10,right:10),
      child: Card(
        elevation: 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                      child: Text("Patient Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                      child: Text("Name: ${widget.user.firstName} ${widget.user.lastName}",style: const TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                      child: Text("Email: ${widget.user.email}", style: const TextStyle(fontSize: 16)),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom:20.0,left:20.0),
                          child: SizedBox(
                            height: 100.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                menuOption2(AppColors.buttonOption2Dark, const Icon(Icons.medication_rounded), const AddPrescription(), "Add Prescription", context),
                                menuOption2(
                                    AppColors.buttonOption1Dark,
                                    const Icon(CupertinoIcons.bubble_left_bubble_right_fill),
                                    ChatScreen(
                                        messageData: MessageData(
                                            null, widget.id, widget.user.id!,
                                            DateTime.now(),"", false),
                                        name: "${widget.user.firstName}  ${widget.user.lastName}" ),
                                    "Message Patient", context),
                                menuOption2(
                                    AppColors.accent,
                                    const Icon(CupertinoIcons.person),
                                    ViewOtherProfile(id: widget.user.id!),
                                    "View Profile", context),
                            ],
                            ),
                          )
                      ),
                    ),
                  ],),
              ),

          ),
        );
  }
}