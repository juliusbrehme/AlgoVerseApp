import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Function()? onTap;

  const HomeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black26,
        child: Ink(
          height: 120,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color.fromRGBO(26, 26, 91, 1),
            image: const DecorationImage(
              image: AssetImage("lib/images/logo.png"),
            ),
            boxShadow: const [BoxShadow(blurRadius: 6.0)],
          ),
        ),
      ),
    );
  }
}
