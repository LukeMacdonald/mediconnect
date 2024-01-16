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
        color: AppColors.cardLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListTile(
            leading: Icon(
              Icons.medication,
              size: 60,
              color: AppColors.secondary,
            ),
            contentPadding: const EdgeInsets.all(10),
            title: Text(
                "Name: ${widget.prescription.name} (${widget.prescription.dosage} mg)\nRepeats: ${widget.prescription.repeats}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)), //Text(_appointment[index]),
          ),
        ),
      ),
    );
  }
}
