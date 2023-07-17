import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  final String title;
  final String hint;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String? value)? validator;
  final String? value;
  const DropDownMenu({
    required this.hint,
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(15.0),
        value: value,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 30,
        ),
        isExpanded: true,
        alignment: AlignmentDirectional.bottomEnd,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.indigo, width: 3),
          ),
          hintText: hint,
          labelText: title,
          labelStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          hintStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        items: items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
