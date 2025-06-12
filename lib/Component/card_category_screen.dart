import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Build_Card_Category_Screen ({
  required String title,
  required String imagePath,
    }) =>  Column(
    children: [
    Container(
      width: 130,
      height: 129,
      child: Card(
        child: Image.asset(imagePath),
    ),
    ),
      Text(title)
    ],
    );