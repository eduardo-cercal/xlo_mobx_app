import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  final String label;
  final Function(int?) onChanged;
  final int? initialValue;

  const PriceField(
      {Key? key,
      required this.label,
      required this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixText: "R\$ ",
          border: const OutlineInputBorder(),
          isDense: true,
          labelText: label,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter()
        ],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16),
        onChanged: (text) {
          onChanged(int.tryParse(text.replaceAll(".", "")));
        },
        initialValue: initialValue?.toString(),
      ),
    );
  }
}
