import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String image;
  final String description;
  final Function()? onTap;

  const OptionButton(
      {super.key,
      required this.image,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListTile(
        leading: SizedBox(
          height: 45,
          width: 50,
          child: Image.asset(image),
        ),
        title: Text(
          description,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        splashColor: Colors.grey[500],
      ),
    );
  }
}
