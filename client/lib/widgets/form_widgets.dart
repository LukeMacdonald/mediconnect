import 'package:intl/intl.dart';
import '../../utilities/imports.dart';

class UserEmail extends StatefulWidget {
  const UserEmail({
    Key? key,
    required this.changeClassValue,
  }) : super(key: key);
  final ValueChanged<String> changeClassValue;

  @override
  State<UserEmail> createState() => _UserEmail();
}

class _UserEmail extends State<UserEmail> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(mainAxisSize: MainAxisSize.max, children: [
    Expanded(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Material(
    color: Theme.of(context).cardColor,
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: textController,
                obscureText: false,
                autofocus: true,
                onChanged: (val) {
                  UserSecureStorage.setEmail(textController.text);
                  widget.changeClassValue(textController.text);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email Address',
                  labelStyle: CustomTextStyles.formInputStyle,
                  hintText: 'Enter your email address...',
                  hintStyle: CustomTextStyles.formInputStyle,
                ),
                style: CustomTextStyles.formInputStyle,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        ))
      ],
    ));
  }
}

class UserGivenFirstName extends StatefulWidget {
  const UserGivenFirstName({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGivenFirstName> createState() => _UserGivenFirstName();
}

class _UserGivenFirstName extends State<UserGivenFirstName> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Material(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: textController,
                          obscureText: false,
                          onChanged: (val) {
                            UserSecureStorage.setFirstName(textController.text);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'First Name',
                            labelStyle: CustomTextStyles.formInputStyle,
                            hintText: 'Enter your first name...',
                            hintStyle: CustomTextStyles.formInputStyle,
                          ),
                          style: CustomTextStyles.formInputStyle,
                          keyboardType: TextInputType.name,
                        )))))
      ]),
    );
  }
}

class UserGivenLastName extends StatefulWidget {
  const UserGivenLastName({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGivenLastName> createState() => _UserGivenLastName();
}

class _UserGivenLastName extends State<UserGivenLastName> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Material(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: textController,
                          obscureText: false,
                          onChanged: (val) {
                            UserSecureStorage.setLastName(textController.text);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Last Name',
                            labelStyle: CustomTextStyles.formInputStyle,
                            hintText: 'Enter your last name...',
                            hintStyle: CustomTextStyles.formInputStyle,
                          ),
                          style: CustomTextStyles.formInputStyle,
                          keyboardType: TextInputType.name,
                        )))))
      ]),
    );
  }
}

class UserGivenPassword extends StatefulWidget {
  const UserGivenPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGivenPassword> createState() => _UserGivenPassword();
}

class _UserGivenPassword extends State<UserGivenPassword> {
  final textController = TextEditingController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              onChanged: (val) {
                                UserSecureStorage.setPassword(
                                    textController.text);
                              },
                              validator: (val) {
                                if (val == "") {
                                  return 'Password is empty';
                                }
                                return null;
                              },
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                  labelStyle: CustomTextStyles.formInputStyle,
                                  //hintText: 'Enter Password',
                                  hintStyle: CustomTextStyles.formInputStyle,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                    ),
                                  )),
                              style: CustomTextStyles.formInputStyle,
                            )))))
          ],
        ));
  }
}

class UserGivenConfirmPassword extends StatefulWidget {
  const UserGivenConfirmPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGivenConfirmPassword> createState() => _UserGivenConfirmPassword();
}

class _UserGivenConfirmPassword extends State<UserGivenConfirmPassword> {
  final textController = TextEditingController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              onChanged: (val) {
                                UserSecureStorage.setConfirmPassword(
                                    textController.text);
                              },
                              validator: (val) {
                                if (val == "") {
                                  return 'Password is empty';
                                }
                                return null;
                              },
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Confirm Password',
                                  labelStyle: CustomTextStyles.formInputStyle,
                                  hintText: 'Enter Password',
                                  hintStyle: CustomTextStyles.formInputStyle,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                    ),
                                  )),
                              style: CustomTextStyles.formInputStyle,
                            )))))
          ],
        ));
  }
}

class UserGivenPhoneNumber extends StatefulWidget {
  const UserGivenPhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGivenPhoneNumber> createState() => _UserGivenPhoneNumber();
}

class _UserGivenPhoneNumber extends State<UserGivenPhoneNumber> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              onChanged: (val) {
                                UserSecureStorage.setPhoneNumber(
                                    textController.text);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Phone Number ',
                                labelStyle: CustomTextStyles.formInputStyle,
                                hintText: '1800160401',
                                hintStyle: CustomTextStyles.formInputStyle,
                              ),
                              style: CustomTextStyles.formInputStyle,
                              keyboardType: TextInputType.phone,
                            )))))
          ],
        ));
  }
}

class UserDOB extends StatefulWidget {
  const UserDOB({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDOB> createState() => _UserDOB();
}

class _UserDOB extends State<UserDOB> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'DOB',
                                labelStyle: CustomTextStyles.formInputStyle,
                                hintText: 'Enter your date of birth...',
                                hintStyle: CustomTextStyles.formInputStyle,
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(
                                          pickedDate); // Note that backend needs this format for string to be converted!!
                                  setState(() {
                                    textController.text = formattedDate;
                                    // Will be converted in backend
                                  });
                                  UserSecureStorage.setDOB(textController.text);
                                }
                              },
                              style: CustomTextStyles.formInputStyle,
                            )))))
          ],
        ));
  }
}

class DoctorCode extends StatefulWidget {
  const DoctorCode({Key? key, required this.changeClassValue})
      : super(key: key);

  final ValueChanged<String> changeClassValue;
  @override
  State<DoctorCode> createState() => _DoctorCode();
}

class _DoctorCode extends State<DoctorCode> {

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              onChanged: (val) {
                                widget.changeClassValue(textController.text);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter Code ',
                                labelStyle: CustomTextStyles.formInputStyle,
                                hintText: '0000000',
                                hintStyle: CustomTextStyles.formInputStyle,
                              ),
                              style: CustomTextStyles.formInputStyle,
                              keyboardType: TextInputType.number,
                            )))))
          ],
        ));
  }
}

class CustomTextStyles {
  static const TextStyle formInputStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}


