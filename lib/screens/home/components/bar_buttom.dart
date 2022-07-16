import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final BoxDecoration decoration;
  final String label;
  final VoidCallback onTap;

  const BarButton({Key? key, required this.decoration, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: decoration,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
