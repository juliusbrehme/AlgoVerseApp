import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String image;
  final String description;
  final Function()? onTap;
  final double height;
  final double width;

  const OptionButton({
    super.key,
    required this.image,
    required this.description,
    required this.onTap,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListTile(
        leading: SizedBox(
          height: height,
          width: width,
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
