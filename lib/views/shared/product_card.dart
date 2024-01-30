import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shopping_app/controller/favourite_provider.dart';
import 'package:online_shopping_app/models/constant.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/shared/reusable_test.dart';
import 'package:online_shopping_app/views/ui/favourite.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  const ProductCard({super.key,
  required this.price,
  required this.category,
  required this.id,
  required this.name,
  required this.image});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  final _favBox = Hive.box('fav_box');


  @override
  Widget build(BuildContext context) {
    var favouriteNotifier = Provider.of<FavouriteNotifier> (context, listen: true);
    favouriteNotifier.getFavourites();
    bool selected = true;
    return Padding(padding: EdgeInsets.only(left: 8.w, right: 20.w),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Container(
        height: 325.h,
        width: 225.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(1, 1),
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 186.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image))
                  ),
                ),
                Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () async {
                        if(favouriteNotifier.ids.contains(widget.id )){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Favourite()));
                        } else {
                          favouriteNotifier.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image
                          });
                        }
                        setState(() {
                        });
                      },
                      child: favouriteNotifier.ids.contains(widget.id)? Icon(AntDesign.heart)
                          :Icon(AntDesign.hearto),
                    ))
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(text: widget.name, style: appstyleWithHt(
                    34, Colors.black, FontWeight.bold, 1.1),),
                ReusableText(text:widget.category, style: appstyleWithHt(
                    18, Colors.grey, FontWeight.bold, 1.5),)
              ],
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(text:widget.price,

                  style: appstyle(
                    30, Colors.black, FontWeight.w600),),
                Row(
                  children: [
                    ReusableText(text:"Colors", style: appstyle(
                    18, Colors.grey, FontWeight.w500),),
                    SizedBox(width: 5.w,),
                    ChoiceChip(label: Text(""),
                        selected: selected,
                    visualDensity: VisualDensity.compact,
                      selectedColor: Colors.black,
                    ),

                  ],
                )
              ],
            ),
            )
          ],
        ),
      ),
    )
    );
  }
}
