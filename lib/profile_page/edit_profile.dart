import 'package:flutter/material.dart';
import 'package:nexgen/Component/edit_profile_component.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? dropdownValue; // نبدأ بدون قيمة

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // عشان ما يصير overflow في الشاشات الصغيرة
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(
                                  "Assets/hazem.jpg",
                                  fit: BoxFit.cover,
                                  width: 55,
                                  height: 55,
                                ),
                              ),
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "user name",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // اسم المستخدم
              EditProfileField(
                context: context,
                hintText: " Your Nickname",
                controller: nameController,
                keyboardType: TextInputType.text,
                icon: Icons.account_circle,
              ),

              // التاريخ
              EditProfileField(
                context: context,
                hintText: "Your Phone number",
                controller: TextEditingController(),
                keyboardType: TextInputType.phone,
                icon: Icons.phone_android_outlined,
                isDatePicker: false,
              ),
              EditProfileField(
                context: context,
                hintText: "Select Date",
                controller: dateController,
                keyboardType: TextInputType.datetime,
                icon: Icons.calendar_today,
                isDatePicker: true,
              ),

              EditProfileField(
                isDropdown: true,
                dropdownValue: "Male", // لازم تكون واحدة من القيم الموجودة في الـ items
                hintText: "Select...",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                context: context,
                on_change: (val) {
                 val ;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  ),
                  color: Color(0xFF0098FF),
                  minWidth: 230,
                  height: 65,
                  onPressed: () {
                    final updatedData = {
                      'name': nameController.text,
                      'date': dateController.text,
                      'gender': dropdownValue,

                    };

                    Navigator.pop(context, updatedData);
                  },
                 child: Text(
                     "Update Profile ",
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 20,
                     color: Colors.white
                   ),
                 ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
