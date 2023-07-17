import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String)? onchange;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;

  const InputField({
    required this.title,
    required this.hint,
    this.validator,
    this.onchange,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.controller,
    this.obscureText,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: TextFormField(
          readOnly: readOnly ?? false,
          controller: controller,
          onChanged: onchange,
          onFieldSubmitted: onchange,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            filled: true,
            hintText: hint,
            labelText: title,
            hintStyle: const TextStyle(fontWeight: FontWeight.normal),
            suffixIcon: suffix,
            errorStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          obscureText: obscureText ?? false,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
