import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField2 extends StatelessWidget {
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String)? onchange;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final TextEditingController? controller;

  const InputField2({
    required this.title,
    required this.hint,
    this.validator,
    this.onchange,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        onChanged: onchange,
        onFieldSubmitted: onchange,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            suffix: suffix),
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
