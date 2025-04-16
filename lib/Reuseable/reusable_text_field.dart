import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Function(DateTime?)? onDateTimeSelected; // Callback for DateTime picker
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;

  final String? initialValue;

  const ReusableTextField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.inputFormatters,
    this.validator,
    this.onDateTimeSelected,
    this.onSaved,
    this.onChanged,
    this.initialValue, // Added callback for DateTime picker
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        onSaved: onSaved,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        validator: validator,
        onTap: () async {
          if (keyboardType == TextInputType.datetime &&
              onDateTimeSelected != null) {
            DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
// Agar user cancel kare, to current date set ho jaye
            dateTime ??= DateTime.now();

            TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (timeOfDay != null) {
              dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
                  timeOfDay.hour, timeOfDay.minute);
              onDateTimeSelected!(dateTime);
            }
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
