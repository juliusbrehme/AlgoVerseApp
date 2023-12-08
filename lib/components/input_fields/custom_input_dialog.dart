import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputDialog extends StatefulWidget {
  const CustomInputDialog({
    required this.title,
    this.onSubmit,
    this.onSubmitFuture,
    required this.smallerHundred,
    super.key,
  });

  final String title;
  final void Function(List<int>)? onSubmit;
  final Future<void> Function(List<int>)? onSubmitFuture;
  final bool smallerHundred;

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  final TextEditingController _controller = TextEditingController();
  Set<int> resultsList = {};

  void removeNumber(int value) {
    setState(() {
      resultsList.remove(value);
    });
  }

  void addNumber() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        resultsList.add(int.parse(_controller.text));
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int value = widget.smallerHundred ? 100 : 1000;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            widget.title,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
              children: List.generate(
            resultsList.length,
            (index) {
              return NumberBox(
                index: index,
                number: resultsList.toList()[index],
                onTap: removeNumber,
              );
            },
          )),
          resultsList.isNotEmpty ? const SizedBox(height: 5) : const SizedBox(),
          resultsList.isNotEmpty
              ? Text(
                  "Tap to remove",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 14,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: const Color(0xffafafaf))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    style: TextStyle(color: Colors.grey[900]),
                    decoration: InputDecoration(
                        hintText: 'E.g. 34    (0 < $value)',
                        hintStyle: TextStyle(color: Colors.grey[900]),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(widget.smallerHundred
                          ? RegExp(r'^[1-9][0-9]{1}$|^\d$')
                          : RegExp(r'^[1-9][0-9]{1,2}$|^\d$')),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => newValue.copyWith(
                          text: newValue.text.replaceAll('.', ','),
                        ),
                      ),
                    ],
                    onEditingComplete: () {
                      addNumber();
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addNumber();
                  },
                  child: const Text(
                    "Add +",
                    style: TextStyle(
                        color: Color.fromRGBO(51, 74, 100, 1), fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
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
                  resultsList.isNotEmpty
                      ? widget.onSubmit != null
                          ? widget.onSubmit!(resultsList.toList())
                          : widget.onSubmitFuture != null
                              ? widget.onSubmitFuture!(resultsList.toList())
                              : null
                      : null;
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

class NumberBox extends StatelessWidget {
  final int index;
  final int number;
  final Function(int) onTap;

  const NumberBox(
      {super.key,
      required this.number,
      required this.onTap,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(number);
      },
      child: Container(
        width: 50,
        height: 30,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: const Color.fromRGBO(51, 74, 100, 1),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Arial',
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
