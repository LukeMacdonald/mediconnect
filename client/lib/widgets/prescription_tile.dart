import '../../utilities/imports.dart';

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
