import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final double size;
  const ExpandableText({super.key, required this.text, this.size = 12});

  @override
  State<ExpandableText> createState() => _ExpanableTextState();
}

class _ExpanableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150 + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: [
                Text(
                  maxLines: hiddenText ? 3 : null,
                  hiddenText ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: const TextStyle(color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    print(hiddenText);
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: hiddenText
                        ? [
                            const Text(
                              'Thêm',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.blue,
                            ),
                          ]
                        : [
                            const Text(
                              'Giấu',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_up_outlined,
                              color: Colors.blue,
                            ),
                          ],
                  ),
                )
              ],
            ),
    );
  }
}
