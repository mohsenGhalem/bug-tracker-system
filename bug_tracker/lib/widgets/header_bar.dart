import 'package:flutter/material.dart';

import 'input_field.dart';

class HeaderBar extends StatelessWidget {
  final String btnTitle;
  final void Function()? onPressed;
  final void Function(String)? onchange;
  const HeaderBar(
      {super.key,
      required this.btnTitle,
      required this.onPressed,
      this.onchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Row(
        children: [
          Expanded(
            child: InputField(
              title: 'Search',
              hint: 'search here',
              onchange: onchange,
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'enter a text to search first'
                    : null;
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.add),
              label: Text(
                btnTitle,
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: onPressed,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
