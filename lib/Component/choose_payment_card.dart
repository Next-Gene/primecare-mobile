import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Payment_Card({
    required String text1,
    required String image_path,
     VoidCallback? onTap,
  })=>

InkWell(
  onTap: onTap,
  child: Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15)
      ),
      width: 300,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
                color: Color(0xFF363639)

            ),
          ),
          Spacer(),

          Image.asset(
            image_path,
            width: 30,
            height: 30,
          )
        ],
        ),
      ),
    ),
  ),
);



