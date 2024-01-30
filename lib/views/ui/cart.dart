import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shopping_app/controller/cart_provider.dart';
import 'package:online_shopping_app/views/shared/app_style.dart';
import 'package:online_shopping_app/views/shared/checkout)btn.dart';
import 'package:online_shopping_app/views/ui/main_secreen.dart';
import 'package:provider/provider.dart';

class CartP extends StatefulWidget {
  const CartP({super.key});

  @override
  State<CartP> createState() => _CartPState();
}

class _CartPState extends State<CartP> {
  get doNothing => null;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){},
                  child: Icon(AntDesign.close, color: Colors.black,),
                ),
                Text("My Cart",
                  style: appstyle(35, Colors.black, FontWeight.bold),),
                SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.65,
                  child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index){
                        final data = cartProvider.cart[index];
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12),),
                            child: Slidable(
                              key: ValueKey(0),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: doNothing,
                                    backgroundColor: Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: "Delete",
                                  )
                                ],
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: Offset(0, 1),
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Padding(padding: EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'],
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: -2,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    cartProvider.deleteCart(data['key']);
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(builder:
                                                        (context)=> MainSecreen()));
                                                  },
                                                  child: Container(
                                                    width: 40,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(12),
                                                      )
                                                    ),
                                                    child: Icon(AntDesign.delete, size: 20,
                                                    color: Colors.white,),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 12, left: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data['name'],
                                                style: appstyle(16, Colors.black, FontWeight.bold),),
                                              SizedBox(height: 5,),
                                              Text(data['category'],
                                                  style: appstyle(14, Colors.grey, FontWeight.w500,)),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text(data['price'],
                                                    style: appstyle(18, Colors.black, FontWeight.w500),),
                                                  SizedBox(width: 40,),
                                                  Text("Size",
                                                    style: appstyle(18, Colors.black, FontWeight.w500),),
                                                  SizedBox(width: 10,),
                                                  Text("${data['sizes']}",
                                                    style: appstyle(18, Colors.black, FontWeight.w500),),
                                                ],
                                              ),
                                            ],
                                          ),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(padding: EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(16)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    //cartProvider.increment();
                                                  },
                                                  child: Icon(AntDesign.minussquare, size: 20,
                                                    color: Colors.grey,),
                                                ),
                                                Text(data['qty'].toString(),
                                                  style: appstyle(12, Colors.black, FontWeight.w600),),
                                                InkWell(
                                                  onTap: (){
                                                    //cartProvider.decrement();
                                                  },
                                                  child: Icon(AntDesign.plussquare, size: 20,
                                                    color: Colors.black,),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            Align(alignment: Alignment.bottomCenter,
              child: CheckoutButton(
                label: "Proceed to Checkout",
              ),)
          ],
        ),
      ),
    );
  }

}
