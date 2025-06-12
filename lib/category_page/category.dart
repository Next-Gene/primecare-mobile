import 'package:flutter/material.dart';
import 'package:nexgen/Component/card_category_screen.dart';

import 'List_category.dart';

class Category_page extends StatelessWidget {
  const Category_page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE7F6FF), // أول لون
                  Color(0xFF90D3FD), // ثاني لون
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Category",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: category_map.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final index_category = category_map[index];
                    return Build_Card_Category_Screen(
                      title: index_category["title"]!,
                      imagePath: index_category["image"]!,
                    );
                  },
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
