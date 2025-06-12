import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget EditProfileField({
  required String hintText,
  IconData? icon,
  required TextEditingController controller,
  required TextInputType keyboardType,
  bool isDatePicker = false,
  bool isDropdown = false,
  String? dropdownValue,
  required BuildContext context,
  void Function(String?)? on_change
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
    child: SizedBox(
      height: 60,
      child: isDropdown? DropdownButtonFormField<String>(
        value: dropdownValue,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.people_alt),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        items: const [
          DropdownMenuItem(value: "Male", child: Text("Male")),
          DropdownMenuItem(value: "Female", child: Text("Female")),
        ],
        onChanged: on_change
      )
          :TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isDatePicker, // مهم عشان ميكتبش فيه لو هو DatePicker
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: Icon(icon),
          ) : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        onTap: isDatePicker ? () async {
          FocusScope.of(context).unfocus(); // يغلق الكيبورد
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (selectedDate != null) {
          String formattedDate = DateFormat.yMMMd().format(selectedDate);
          controller.text = formattedDate;
          }
        } : null,
      ),
    ),
  );
}
