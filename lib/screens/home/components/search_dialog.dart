import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final TextEditingController controller;
  final String? currentSearch;

  SearchDialog({Key? key, this.currentSearch})
      : controller = TextEditingController(text: currentSearch),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.grey[700],
                ),
                suffixIcon: IconButton(
                  onPressed: controller.clear,
                  icon: const Icon(Icons.close),
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
