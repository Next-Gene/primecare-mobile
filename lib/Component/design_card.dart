import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class sigin_card extends StatelessWidget {
  const sigin_card
      ({
    super.key,
    required this.Text1,
    required this.icon,
    this.styling,
  });

  final String Text1;
  final Widget icon;
  final TextStyle? styling;


  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder (
          borderRadius:BorderRadius.circular(20),
          side: BorderSide(color: Colors.black12)
      ),
      child: Padding(
        padding: const EdgeInsets.only( top: 20, bottom: 20,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(Text1,style: styling,)
          ],
        ),
      ),
    );
  }
}
