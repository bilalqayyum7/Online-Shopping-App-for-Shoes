import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shopping_app/controller/product_provider.dart';
import 'package:online_shopping_app/models/sneakers_models.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/shared/new_shoes.dart';
import 'package:online_shopping_app/views/shared/product_card.dart';
import 'package:online_shopping_app/views/shared/reusable_test.dart';
import 'package:online_shopping_app/views/ui/product_by_cart.dart';
import 'package:online_shopping_app/views/ui/product_page.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {

  const HomeWidget({super.key,
    required this.tabIndex,
    required Future<List<Sneakers>> male}) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 325.h,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                } else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        final shoes = snapshot.data![index];
                        return GestureDetector(
                          onTap: (){
                            productNotifier.shoesSizes = shoes.sizes;
                            // print(productNotifier.shoeSize );
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(id: shoes.id, category: shoes.category)));
                          },
                          child: ProductCard(
                            price: "\$${shoes.price}",
                            category: shoes.category,
                            id: shoes.id,
                            name: shoes.name,
                            image: shoes.imageUrl[0],
                          ),
                        );
                      });
                }
              },
            )
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(text:"Latest Shoes", style: appstyle(
                      24, Colors.black, FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> ProductByCart(
                            tabIndex: tabIndex,
                          )));
                    },
                    child: Row(
                      children: [
                        ReusableText(text:"Shoes All", style: appstyle(
                            22, Colors.black, FontWeight.w500),),
                        Icon(AntDesign.caretright, size: 20,)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: 99.h,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                } else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        final shoes = snapshot.data![index];
                        return NewShoes(
                          onTap: (){
                            productNotifier.shoesSizes = shoes.sizes;
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                (context)=> ProductPage(id: shoes.id,
                                    category: shoes.category)));
                          },
                          imageUrl: shoes.imageUrl[1],);
                      });
                }
              },
            )
        )
      ],
    );
  }
}
