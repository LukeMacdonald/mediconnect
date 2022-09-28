import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../styles/custom_styles.dart';


class UserEmail extends StatefulWidget {
  const UserEmail ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserEmail> createState() => _UserEmail();

}
class _UserEmail extends State<UserEmail> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  autofocus: true,
                  onChanged: (val) {
                    widget.changeClassValue(textController.text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Enter your email address...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.emailAddress,
                )))
      ],
    );
  }
}

class UserGivenFirstName extends StatefulWidget {
   const UserGivenFirstName ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserGivenFirstName> createState() => _UserGivenFirstName();

  }
class _UserGivenFirstName extends State<UserGivenFirstName> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  onChanged: (val) {
                    widget.changeClassValue(textController.text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    hintText: 'Enter your first name...',
                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                  keyboardType: TextInputType.name,
                )
            )
        )
      ],
    );
  }
}

class UserGivenLastName extends StatefulWidget {
  const UserGivenLastName ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserGivenLastName> createState() => _UserGivenLastName();

}
class _UserGivenLastName extends State<UserGivenLastName> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  onChanged: (val) {
                    widget.changeClassValue(textController.text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    hintText: 'Enter your last name...',
                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                  keyboardType: TextInputType.name,
                )
            )
        )
      ],
    );
  }
}

class UserGivenPassword extends StatefulWidget {

  const UserGivenPassword ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserGivenPassword> createState() => _UserGivenPassword();

}
class _UserGivenPassword extends State<UserGivenPassword> {
  final textController = TextEditingController();
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: textController,
                  onChanged: (val) {
                    widget.changeClassValue(textController.text);
                  },
                  validator: (val) {
                    if (val == "") {
                      return 'Password is empty';
                    }
                    return null;
                  },
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                      //hintText: 'Enter Password',
                      hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                        ),
                      )),
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                )))
      ],
    );
  }
}

class UserGivenConfirmPassword extends StatefulWidget {
  const UserGivenConfirmPassword ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserGivenConfirmPassword> createState() => _UserGivenConfirmPassword();

}
class _UserGivenConfirmPassword extends State<UserGivenConfirmPassword> {
  final textController = TextEditingController();
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: textController,
                  onChanged: (val) {
                    widget.changeClassValue(textController.text);
                  },
                  validator: (val) {
                    if (val == "") {
                      return 'Password is empty';
                    }
                    return null;
                  },
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                      hintText: 'Enter Password',
                      hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                        ),
                      )),
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                )))
      ],
    );
  }
}

class UserGivenPhoneNumber extends StatefulWidget {
  const UserGivenPhoneNumber ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserGivenPhoneNumber> createState() => _UserGivenPhoneNumber();

}
class _UserGivenPhoneNumber extends State<UserGivenPhoneNumber> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      onChanged: (val) {
                        widget.changeClassValue(textController.text);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone Number ',
                        labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                        hintText: '1800160401',
                        hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                        enabledBorder: CustomOutlineInputBorder.custom,
                        focusedBorder: CustomOutlineInputBorder.custom,
                        errorBorder: CustomOutlineInputBorder.custom,
                        focusedErrorBorder: CustomOutlineInputBorder.custom,
                      ),
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                      keyboardType: TextInputType.phone,
                    )))
          ],
        ));
  }
}

class UserDOB extends StatefulWidget {
  const UserDOB ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<UserDOB> createState() => _UserDOB();

}
class _UserDOB extends State<UserDOB> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    labelText: 'DOB',
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    hintText: 'Enter your date of birth...',
                    hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // Note that backend needs this format for string to be converted!!
                      setState(() {
                        textController.text = formattedDate;
                        // Will be converted in backend
                      });
                      widget.changeClassValue(textController.text);
                    }
                  },
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                )))
      ],
    );
  }
  }

class DoctorCode extends StatefulWidget {
  const DoctorCode  ({
    Key? key,
    required this.changeClassValue
  }) : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<DoctorCode> createState() => _DoctorCode ();

}
class _DoctorCode  extends State<DoctorCode> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      onChanged: (val) {
                        widget.changeClassValue(textController.text);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Code ',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: '0000000',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: CustomOutlineInputBorder.custom,
                        focusedBorder: CustomOutlineInputBorder.custom,
                        errorBorder: CustomOutlineInputBorder.custom,
                        focusedErrorBorder: CustomOutlineInputBorder.custom,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.number,
                    )))
          ],
        ));
  }
}

