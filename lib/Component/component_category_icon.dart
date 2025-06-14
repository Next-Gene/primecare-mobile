import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget default_categories_icon({
  required Color background_color,
  required String text1,
  required String imagePath,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: background_color,
            radius: 27,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22), // 👈 دي بتدي الصورة شكل دائري أو شبه دائري
              child: Image.network(
                imagePath,
                width: 45,
                height: 45,
                fit: BoxFit.cover, // الأفضل cover علشان يملى الشكل
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 65,
            height: 45,
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
