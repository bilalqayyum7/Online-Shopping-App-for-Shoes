import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';

class CheckoutButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const CheckoutButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width*0.9,
          child: Center(
            child: Text(label,
              style: appstyle(20, Colors.white, FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
