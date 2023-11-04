import 'package:flutter/material.dart';

class HighlightedOptionButton extends StatelessWidget {
  final String image;
  final String description;
  final Function()? onTap;

  const HighlightedOptionButton(
      {super.key,
      required this.image,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
              //color: Color.fromRGBO(239, 237, 93, 0.7),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(239, 237, 93, 0.0),
                Color.fromRGBO(239, 237, 93, 0.6),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              border: Border(
                  right: BorderSide(
                color: Color.fromRGBO(239, 237, 93, 1),
                width: 4,
              ))),
        ),
        Padding(
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
                color: Color.fromRGBO(239, 237, 295, 1),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            onTap: onTap,
            splashColor: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
