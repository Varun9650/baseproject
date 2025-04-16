import 'package:flutter/material.dart';

class ReusableDropdownField extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> options;
  final String? value;
  final String valueField; // ID key (dynamic)
  final String uiField; // Name key (dynamic)
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;

  const ReusableDropdownField({
    super.key,
    required this.label,
    required this.options,
    required this.valueField, // Dynamic ID field
    required this.uiField, // Dynamic Name field
    this.value,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                const BorderSide(color: Colors.deepPurpleAccent, width: 2),
          ),
        ),
        value: (value != null && value!.isNotEmpty) ? value : null,
        items: [
          const DropdownMenuItem<String>(
            value: '',
            child: Text('Select an option'),
          ),
          ...options.map<DropdownMenuItem<String>>(
            (item) => DropdownMenuItem<String>(
              value: item[valueField].toString(),
              child: Text(
                item[uiField].toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
        onChanged: onChanged,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a $label';
          }
          return null;
        },
      ),
    );
  }
}
