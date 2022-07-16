import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/models/ad.dart';

class BottomBar extends StatelessWidget {
  final Ad ad;

  const BottomBar({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ad.status == AdStatus.pending) return Container();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Theme.of(context).primaryColor),
            child: Row(
              children: [
                if (!ad.hidePhone)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final phone =
                            ad.user.phone.replaceAll(RegExp("[^0-9]"), "");
                        launchUrl(Uri(scheme: "tel", path: phone));
                      },
                      child: Container(
                        height: 25,
                        alignment: Alignment.center,
                        child: const Text(
                          "Ligar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.black45)),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: const Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(color: Colors.grey[400]!),
              ),
            ),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              "${ad.user.name} (anunciante)",
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
