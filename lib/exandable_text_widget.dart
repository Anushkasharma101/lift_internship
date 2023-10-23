import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool showSecondHalf=false;

  @override
  void toggleShowMore() {
    setState(() {
      showSecondHalf = !showSecondHalf;
    });
  }

  Widget build(BuildContext context) {
    String text = "Users can make and receive phone calls, and some cellphones also offer text messaging.  "
        "Users can make and receive phone calls, and some cellphones also offer text messaging. ";

    return Column(
      children: [
        Text(
          showSecondHalf
              ? text
              : text.substring(0, text.length ~/ 2),
          style: TextStyle(fontSize: 16),
        ),
        if (text.length > 40)  // Conditionally show "Show More" button
          TextButton(
            onPressed: toggleShowMore,
            child: Text(showSecondHalf ? "Show Less" : "Show More"),
          ),
      ],
    );
  }
}
