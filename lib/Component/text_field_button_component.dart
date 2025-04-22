import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

    Widget defaultButton ({
        required double width ,
        required Color background,
        required VoidCallback  function ,
        required String text

    }) => Container(
      width: width,
      height: 61,
      decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(31),
      ),
      child: MaterialButton(
      onPressed: function ,
      child: Text(
        text,
        style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 21
      ),),
      ),
        );









Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  bool ispassword = false,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixpressed,
}) => TextFormField(
  validator: validate,
  controller: controller,
  keyboardType: type,
  obscureText: ispassword,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    labelStyle: TextStyle(color: Colors.black87),
    hintStyle: TextStyle(color: Colors.black54),
    prefixIcon: Icon(prefix, color: Colors.black54),
    suffixIcon: suffix != null
        ? IconButton(
      icon: Icon(suffix, color: Colors.black54),
      onPressed: suffixpressed,
    )
        : null,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black12, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
  ),
);
