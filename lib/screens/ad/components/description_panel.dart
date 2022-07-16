import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_mobx/models/ad.dart';

class DescriptionPanel extends StatelessWidget {
  final Ad ad;

  const DescriptionPanel({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 18),
          child: Text(
            "Descrição",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
        ),
        ReadMoreText(
          ad.description,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Ver descrição completa",
          trimExpandedText: " ...menos",
          colorClickableText: Theme.of(context).primaryColor,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
