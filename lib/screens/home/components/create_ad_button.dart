import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CreateAdButton extends StatefulWidget {
  final ScrollController scrollController;

  const CreateAdButton({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<CreateAdButton> createState() => _CreateAdButtonState();
}

class _CreateAdButtonState extends State<CreateAdButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    buttonAnimation = Tween<double>(begin: 0, end: 66).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.6)));
    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final s = widget.scrollController.position;

    if (s.userScrollDirection == ScrollDirection.forward) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation,
        builder: (_, __) {
          return FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(
                bottom: buttonAnimation.value,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states) =>
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).primaryColor,
                    )),
                onPressed: () {
                  GetIt.I<PageStore>().setPage(1);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "Anunciar agora",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
