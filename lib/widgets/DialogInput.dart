import 'package:flutter/material.dart';

class DialogInput extends StatelessWidget {
  const DialogInput(
      {Key? key,
      this.controller,
      this.label,
      this.pass = false,
      this.autofocus = false})
      : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final bool pass;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(border: UnderlineInputBorder(), labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter $label';
        }
        return null;
      },
      controller: controller,
      obscureText: pass,
      enableSuggestions: !pass,
      autocorrect: !pass,
      autofocus: autofocus,
    );
  }
}
