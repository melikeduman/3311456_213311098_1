import 'package:flutter/material.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: gray1,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,color: gray5,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text,style: style.bodyMedium?.copyWith(color: gray5),)),
            Icon(Icons.arrow_forward_ios,color: gray3,),
          ],
        ),
      ),
    );
  }
}
