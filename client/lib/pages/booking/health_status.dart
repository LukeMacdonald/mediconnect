import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/imports.dart';

class HeathStatusPage extends StatefulWidget {
  const HeathStatusPage({Key? key}) : super(key: key);

  @override
  State<HeathStatusPage> createState() => _HeathStatusPage();
  }

  class _HeathStatusPage extends State<HeathStatusPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  HealthStatus symptoms = HealthStatus();

  TextEditingController description = TextEditingController();


  bool fever = false;
  bool cough= false;
  bool headache = false;
  bool vomiting= false;
  bool faint= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 6,
          ),
          title: const Text("Book an Appointment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const Padding(
              padding: EdgeInsets.only(top:20,bottom: 20),
              child: Text(
                "Health Status",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom:10.0),
              child: SizedBox(
                  child: Text("Please fill out the below honestly",
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16)),),
            ),
            Expanded(
              child:
                ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top:10),
                      child: SizedBox(
                          child: Text("Do you have any of the following symptoms?")),
                    ),
                    CheckboxListTile(
                        selected:fever,
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Fever/Chills"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: fever,
                        activeColor: AppColors.secondary,
                        onChanged: (bool? value){
                          setState(() {
                            fever = value!;
                            symptoms.fever = fever;
                          });
                    }),
                        CheckboxListTile(
                            selected:cough,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Coughing"),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: cough,
                            activeColor: AppColors.secondary,
                            onChanged: (bool? value){
                              setState(() {
                                cough = value!;
                                symptoms.cough = cough;
                              });
                            })
                        ,CheckboxListTile(
                            selected:headache,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Headaches"),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: headache,
                            activeColor: AppColors.secondary,
                            onChanged: (bool? value){
                              setState(() {
                                headache = value!;
                                symptoms.headache = headache;
                              });
                            })
                        ,CheckboxListTile(
                            selected:vomiting ,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Vomiting"),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: vomiting ,
                            activeColor: AppColors.secondary,
                            onChanged: (bool? value){
                              setState(() {
                                vomiting = value!;
                                symptoms.vomiting = vomiting;
                              });
                            }),
                        CheckboxListTile(
                            selected:faint,
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Fainting"),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: faint,
                            activeColor: AppColors.secondary,
                            onChanged: (bool? value){
                              setState(() {
                                faint = value!;
                                symptoms.faint = faint;
                              });
                            }),
                        const Padding(
                          padding: EdgeInsets.only(top:8.0,bottom: 10),
                          child: Text("To give the doctors a better understanding "
                              "please explain in 1-2 sentences why you "
                              "are booking an appointment?",),
                        ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 8),
                      child: Material(
                        elevation: 5,
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                            child: TextFormField(
                              controller: description,
                              obscureText: false,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                            )
                        ),
                      ))],
                ),
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: SubmitButton(
                        color: AppColors.accent,
                        message: "Submit",
                        width: 225,
                        height: 50,
                        onPressed: (){
                          symptoms.description = description.text;
                          navigate(BookingByTime(symptoms: symptoms,), context);
                        }
                        ,
                      ),
                    ),
                  ],
                )
              ],
            )

          ),
        );
  }
}
