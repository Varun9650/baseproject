import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableDatePickerField extends StatelessWidget {
  final String label;
  final String? initialDate;
  final TextEditingController controller;
  final Function(String?)? onSaved;

  const ReusableDatePickerField({
    super.key,
    required this.label,
    required this.controller,
    this.initialDate,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialDate,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        controller.text = selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : '';
      },
      onSaved: onSaved,
    );
  }
}
