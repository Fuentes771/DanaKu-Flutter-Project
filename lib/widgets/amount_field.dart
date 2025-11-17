import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/formatters.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    this.label = 'Nominal',
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixText: 'Rp ',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, RupiahInputFormatter()],
      validator: validator ?? (v) => (v == null || v.isEmpty) ? 'Nominal wajib diisi' : null,
    );
  }
}
