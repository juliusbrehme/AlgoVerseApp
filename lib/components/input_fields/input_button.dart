import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputButton extends StatelessWidget {
  InputButton({
    super.key,
    required this.title,
    required this.onEditingComplete,
  });

  final String title;
  final Function(TextEditingController) onEditingComplete;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: const Color(0xffafafaf))),
            child: TextField(
              maxLines: 1,
              keyboardType: TextInputType.number,
              controller: _controller,
              style: TextStyle(color: Colors.grey[900]),
              decoration: InputDecoration(
                  hintText: 'E.g. 34    (0 < 1000)',
                  hintStyle: TextStyle(color: Colors.grey[900]),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[1-9][0-9]{1,2}$|^\d$')),
                TextInputFormatter.withFunction(
                  (oldValue, newValue) => newValue.copyWith(
                    text: newValue.text.replaceAll('.', ','),
                  ),
                ),
              ],
              // style: TextStyle(
              //   color: Colors.grey[900],
              //   fontSize: 15,
              //   fontWeight: FontWeight.bold,
              // ),
              // keyboardType: const TextInputType.numberWithOptions(
              //     signed: true, decimal: false),
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'^[1-9][0-9]{1,2}$|^\d$')),
              //   TextInputFormatter.withFunction(
              //     (oldValue, newValue) => newValue.copyWith(
              //       text: newValue.text.replaceAll('.', ','),
              //     ),
              //   ),
              // ],
              // textAlign: TextAlign.center,
              // controller: _controller,
              // decoration: const InputDecoration(
              //     prefixIconConstraints: BoxConstraints(maxWidth: 15),
              //     prefixIcon: Padding(
              //       padding: EdgeInsets.only(left: 8.0),
              //       child: Icon(
              //         Icons.search,
              //         color: Colors.black,
              //       ),
              //     ),
              //     hintMaxLines: 1,
              //     hintText: 'E.g. 34    (0 < 1000)',
              //     hintStyle: TextStyle(
              //       color: Colors.black,
              //     ),
              //     focusedBorder: InputBorder.none,
              //     border: InputBorder.none,
              //     enabledBorder: InputBorder.none),
              onEditingComplete: () {
                onEditingComplete(_controller);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 74, 100, 1),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Color.fromRGBO(51, 74, 100, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  onEditingComplete(_controller);
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
