import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

textField(TextEditingController tec, String label, String hint, Icon icon,
    bool isObscure) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8),
    child: TextFormField(
      controller: tec,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
        helperText: " ",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please type something';
        }
        if (label.toLowerCase() == "email" && !EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    ),
  );
}

pwTextField(TextEditingController tec, TextEditingController tec2, String label,
    String hint, Icon icon, bool isObscure) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8),
    child: TextFormField(
      controller: tec,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
        helperText: " ",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please type something';
        }
        if (label.toLowerCase().contains("confirm") && tec.text != tec2.text) {
          return 'Please re-type the same password';
        }
        if (label.toLowerCase().contains("new password") && value.length < 6) {
          return 'Password should be at least 6 characters';
        }
        return null;
      },
    ),
  );
}