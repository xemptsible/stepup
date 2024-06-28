import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

textField(TextEditingController tec, String label, String hint, Icon icon,
    bool isObscure) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, top: 4),
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
          return 'Vui lòng nhập';
        }
        if (label.toLowerCase() == "email" && !EmailValidator.validate(value)) {
          return 'Vui lòng nhập địa chỉ email';
        }
        return null;
      },
    ),
  );
}

pwTextField(TextEditingController tec, TextEditingController tec2, String label,
    String hint, Icon icon, bool isObscure) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, top: 4),
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
          return 'Vui lòng nhập';
        }
        if (label.toLowerCase().contains("xác nhận")  && tec.text != tec2.text) {
          return 'Vui lòng ghi lại mật khẩu';
        }
        // if (label.toLowerCase().contains("new password") && value.length < 6) {
        //   return 'Password should be at least 6 characters';
        // }
        return null;
      },
    ),
  );
}