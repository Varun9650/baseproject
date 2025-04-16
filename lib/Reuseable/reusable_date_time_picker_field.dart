import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableDateTimePickerField extends StatelessWidget {
  final String label;
  final String? initialDateTime;
  final TextEditingController controller;
  final Function(String?)? onSaved;

  const ReusableDateTimePickerField({super.key, 
    required this.label,
    required this.controller,
    this.initialDateTime,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialDateTime,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          suffixIcon: const Icon(Icons.event),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? selectedDateTime = await showDateTimePicker(
            context: context,
            initialDateTime: DateTime.now(),
          );
          if (selectedDateTime != null) {
            controller.text =
                DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
          }
        },
        onSaved: onSaved,
      ),
    );
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    required DateTime initialDateTime,
  }) async {
    // Custom date-time picker implementation or package usage
    // This is a placeholder for demonstration purposes.
    return await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((date) {
      if (date != null) {
        return showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDateTime),
        ).then((time) {
          if (time != null) {
            return DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
          }
          return date;
        });
      }
      return null;
    });
  }
}
