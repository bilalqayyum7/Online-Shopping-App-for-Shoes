import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/shared/reusable_test.dart';

class StaggerTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  const StaggerTile({super.key, required this.imageUrl,
  required this.name, required this.price});

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl,
            fit: BoxFit.fill,),
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: 75.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(text:widget.name,
                    style: appstyleWithHt(20, Colors.black, FontWeight.w700, 1),),
                  SizedBox(height: 10.h,),
                  ReusableText(text: widget.price,
                    style: appstyleWithHt(20, Colors.black, FontWeight.w500, 1),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
