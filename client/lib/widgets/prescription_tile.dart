import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/models/prescription.dart';
import '../../utilities/imports.dart';
import 'package:page_transition/page_transition.dart';

class PrescriptionTile extends StatefulWidget {
  final Prescription prescription;
  const PrescriptionTile({Key? key, required this.prescription})
      : super(key: key);

  @override
  State<PrescriptionTile> createState() => _PrescriptionTile();
}

class _PrescriptionTile extends State<PrescriptionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: AppColors.buttonOption1Dark,
        // color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(
                "Name: ${widget.prescription.name}\nDosage: ${widget.prescription.dosage}\nRepeats: ${widget.prescription.repeats}"), //Text(_appointment[index]),
          ),
        ),
      ),
    );
  }
}
