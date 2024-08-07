import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stepup/utilities/const.dart';

class SliderCard extends StatelessWidget {
  final String title;
  final String detail;
  final Color color;
  final String img;
  final Color textColor;
  const SliderCard(
      {super.key,
      required this.title,
      required this.detail,
      required this.color,
      required this.img,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  detail,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Image.asset(
            urlimg + img,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
