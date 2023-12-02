import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputButton extends StatelessWidget {
  const InputButton(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.onEditingComplete});

  final TextEditingController controller;
  final Function onTap;
  final Function onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(51, 74, 100, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8,
        ),
        child: TextField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: false),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[1-9]+[0-9]*')),
            TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
                text: newValue.text.replaceAll('.', ','),
              ),
            ),
          ],
          textAlign: TextAlign.center,
          controller: controller,
          decoration: const InputDecoration(
              prefixIconConstraints: BoxConstraints(maxWidth: 15),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              hintMaxLines: 1,
              hintText: "Value",
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none),
          onTap: () => onTap(),
          onEditingComplete: () => onEditingComplete(),
        ),
      ),
    );
  }
}
