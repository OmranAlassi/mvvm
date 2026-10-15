import 'package:flutter/material.dart';

class AppTextFormfield extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String hintText;
  const new({
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: Icon(Icons.phone, color: Colors.blue),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
