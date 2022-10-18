import '../../utilities/imports.dart';

class NotificationAppointmentTile extends StatefulWidget {
  final Appointment appointment;
  const NotificationAppointmentTile({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<NotificationAppointmentTile> createState() =>
      _NotificationAppointmentTile();
}

class _NotificationAppointmentTile extends State<NotificationAppointmentTile> {
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
                "You have an appointment on ${widget.appointment.date} at ${widget.appointment.time}"), //Text(_appointment[index]),
          ),
        ),
      ),
    );
  }
}

class NotificationPrescriptionTile extends StatefulWidget {
  final Prescription prescription;
  const NotificationPrescriptionTile({Key? key, required this.prescription})
      : super(key: key);

  @override
  State<NotificationPrescriptionTile> createState() =>
      _NotificationPrescriptionTile();
}

class _NotificationPrescriptionTile
    extends State<NotificationPrescriptionTile> {
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
                "Remember to take your medicine ${widget.prescription.name} , and the dosage is ${widget.prescription.dosage}"), //Text(_appointment[index]),
          ),
        ),
      ),
    );
  }
}
