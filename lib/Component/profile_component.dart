import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool? isSwitched;
  final ValueChanged<bool>? onSwitchChanged;

  const ProfileOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onTap,
    this.icon,
    this.isSwitched,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
      child: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: const Color(0xFF86D1FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Color(0xFF00006E),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (isSwitched != null && onSwitchChanged != null)
              Switch(
                activeColor: Colors.lightBlue,
                value: isSwitched!,
                onChanged: onSwitchChanged,
              )
            else if (icon != null)
              IconButton(
                onPressed: onTap,
                icon: Icon(icon),
              ),
          ],
        ),
      ),
    );
  }
}
