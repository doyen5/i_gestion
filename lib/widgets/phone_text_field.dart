// lib/widgets/phone_text_field.dart
import 'package:flutter/material.dart';
import '../services/phone_service.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  bool _isValid = true;

  void _validatePhone(String value) {
    final isValid = PhoneService.isValidPhoneNumber(value);
    setState(() {
      _isValid = isValid;
    });

    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Numéro de téléphone',
        hintText: '+225 01 02 03 04 05 ou 0102030405',
        prefixIcon: const Icon(Icons.phone),
        border: const OutlineInputBorder(),
        errorText: widget.errorText ??
            (!_isValid && widget.controller.text.isNotEmpty
                ? 'Format invalide. Ex: +2250102030405'
                : null),
        suffixIcon: widget.controller.text.isNotEmpty
            ? Icon(
                _isValid ? Icons.check_circle : Icons.error,
                color: _isValid ? Colors.green : Colors.red,
              )
            : null,
      ),
      onChanged: _validatePhone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro';
        }
        if (!PhoneService.isValidPhoneNumber(value)) {
          return 'Format invalide. Ex: +2250102030405';
        }
        return null;
      },
    );
  }
}
