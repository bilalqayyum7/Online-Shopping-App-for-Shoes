import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPress;
  final Color buttonClr;
  final String label;
  const CategoryBtn({super.key, required this.buttonClr,
  required this.label, this.onPress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width*0.225,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(
          child: Text(
            label,
            style: appstyle(15, buttonClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
